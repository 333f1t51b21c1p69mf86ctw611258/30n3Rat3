package eonerate.cdrintegration.support;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.ChannelSftp.LsEntry;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

import eonerate.cdrintegration.IntServer;
import eonerate.cdrintegration.config.MainConfig;
import eonerate.cdrintegration.db.dao.SftpFileDAO;
import eonerate.cdrintegration.db.dao.SftpLastestDAO;
import eonerate.cdrintegration.entity.FileItem;
import eonerate.cdrintegration.entity.FileItemComparator;
import eonerate.cdrintegration.entity.ListItem;
import eonerate.cdrintegration.entity.ListItemComparator;
import eonerate.cdrintegration.entity.SftpFile;
import eonerate.cdrintegration.entity.SftpLastest;

/**
 *
 * @author manucian86
 */
public class IntWorker implements Runnable {

	private final Logger LOG = LoggerFactory.getLogger(IntWorker.class);

	private String hostName, userName, password, directory;

	private String sluName;
	private String inputSluFolderPath;

	private List<SftpLastest> sftpLastestList = null;

	private void initSftpLastestList() {

		this.sftpLastestList = SftpLastestDAO.getBySlu(this.sluName);

	}

	public IntWorker(String sluName) {
		this.hostName = IntServer.HostName;
		this.userName = IntServer.UserName;
		this.password = IntServer.Password;
		this.directory = IntServer.Directory;

		this.sluName = sluName;
		this.inputSluFolderPath = this.directory + MainConfig.currentInstance.getInputOsFileSeparator() + sluName;

		initSftpLastestList();
	}

	private List<ListItem> getOrderedFolderList(List<String> dateFolderNames) {

		List<ListItem> result = new ArrayList<ListItem>();

		for (String name : dateFolderNames) {

			ListItem item = new ListItem();
			item.value = name;
			item.key = Integer.parseInt(name.substring(4) + name.substring(0, 2) + name.substring(2, 4));

			result.add(item);

		}

		Collections.sort(result, new ListItemComparator());

		return result;

	}

	private List<FileItem> getOrderedGzipFileList(Vector<ChannelSftp.LsEntry> gzipFiles) {

		List<FileItem> result = new ArrayList<FileItem>();

		for (LsEntry fileEntry : gzipFiles) {

			FileItem item = new FileItem();
			item.value = fileEntry;
			item.key = Integer.parseInt(fileEntry.getFilename().split("\\.")[3]);

			result.add(item);

		}

		Collections.sort(result, new FileItemComparator());

		return result;

	}

	private SftpLastest getSftpLastest(String dateFolder) {
		for (SftpLastest sftpLastest : sftpLastestList) {
			if (sftpLastest.dateFolder.equals(dateFolder)) {

				return sftpLastest;

			}
		}

		SftpLastest sftpLastest = new SftpLastest();
		sftpLastest.slu = this.sluName;
		sftpLastest.dateFolder = dateFolder;
		sftpLastest.lastestCdrTime = 0;
		sftpLastest.changeFlag = true;
		sftpLastestList.add(sftpLastest);

		return sftpLastest;
	}

	private void pullCdrFile(ChannelSftp sftpChannel, String dateFolderName) throws SftpException {
		SftpLastest sftpLastest = getSftpLastest(dateFolderName);

		String inputDateFolderPath = this.inputSluFolderPath + MainConfig.currentInstance.getInputOsFileSeparator() + dateFolderName;

		boolean okCd = false;
		try {
			sftpChannel.cd(inputDateFolderPath);
			okCd = true;
		} catch (SftpException e) {
			LOG.warn("INPUT_DATE_FOLDER isn't found: " + inputDateFolderPath);
		}

		if (okCd) {
			Vector<ChannelSftp.LsEntry> files = sftpChannel.ls("*.gz");
			LOG.info(String.format("* DATE FOLDER: %s; GZIP FILE COUNT: %d", inputDateFolderPath, files.size()));
			List<FileItem> orderFiles = getOrderedGzipFileList(files);

			for (FileItem fileItem : orderFiles) {

				if (fileItem.key > sftpLastest.lastestCdrTime) {

					LsEntry file = fileItem.value;

					if (!file.getAttrs().isDir()) {

						String gzipFileName = file.getFilename();

						//						LOG.info("Process gzip file: " + gzipFileName);

						SftpFile sftpFile = new SftpFile();
						sftpFile.sftpFile = gzipFileName;
						sftpFile.status = 1;
						sftpFile.retry = 0;
						sftpFile.slu = this.sluName;
						sftpFile.note = Constant.PROCESSING;
						sftpFile.fileSize = file.getAttrs().getSize();

						try {

							sftpFile.seq = Integer.parseInt(gzipFileName.split("\\.")[2]);

						} catch (NumberFormatException e) {

							LOG.error("WHEN: Convert seq to number; ERROR: " + e.toString());

						}

						// Neu create SftpFile thanh cong
						if (SftpFileDAO.create(sftpFile)) {

							String inputGzipFilePath = inputDateFolderPath + MainConfig.currentInstance.getInputOsFileSeparator() + gzipFileName;

							String outputFolderPath = MainConfig.currentInstance.getDestFolderPath() + Constant.OUTPUT_OS_FILE_SEPARATOR + sluName + Constant.OUTPUT_OS_FILE_SEPARATOR + dateFolderName;

							// Tao output folder neu chua ton tai
							FileUtil.createFolderIfNotExist(outputFolderPath);

							int retryCount = 0;

							boolean okDownload = false;
							boolean okExtract = false;
							boolean okDeleteGzipFile = false;

							do {
								try {

									sftpChannel.get(inputGzipFilePath, outputFolderPath);

									okDownload = true;

								} catch (SftpException e) {

									sftpFile.note = "ERROR WHEN: DOWNLOAD SFTP GZIP FILE; " + e.toString();

									retryCount++;
									LOG.error("WHEN: Download SFTP Gzip file: " + inputGzipFilePath + "; to folder: " + outputFolderPath + "; RETRY COUNT: " + retryCount);

									try {
										Thread.sleep(MainConfig.currentInstance.getRetryDownloadFileSleepTime());
									} catch (InterruptedException e1) {
										e1.printStackTrace();
									}
								}
							} while (retryCount < MainConfig.currentInstance.getRetryCount() + 1 && !okDownload);

							if (okDownload) {

								String outputGzipFilePath = outputFolderPath + Constant.OUTPUT_OS_FILE_SEPARATOR + gzipFileName;
								// Neu can extract ra cung folder voi file .gz
								//								String outputCdrFilePath = outputFolderPath + Constant.OUTPUT_OS_FILE_SEPARATOR + gzipFileName.substring(0, gzipFileName.length() - 3);
								String outputCdrFilePath = MainConfig.currentInstance.getDestFolderPath() + Constant.OUTPUT_OS_FILE_SEPARATOR + gzipFileName.substring(0, gzipFileName.length() - 3);

								okExtract = FileUtil.extractGzipFile(outputGzipFilePath, outputCdrFilePath);

								if (okExtract) {

									if (MainConfig.currentInstance.isDeleteGzipFile()) {

										File outputGzipFile = new File(outputGzipFilePath);
										okDeleteGzipFile = outputGzipFile.delete();

										if (!okDeleteGzipFile) {

											sftpFile.note = "ERROR WHEN: DELETE GZIP FILE";

										}

										//									try {
										//										
										//									} catch (IOException e) {
										//
										//										sftpFile.desc = "ERROR WHEN: DELETE GZIP FILE; " + e.toString();
										//
										//										LOG.error("WHEN: Delete Output Gzip file: " + outputGzipFilePath);
										//
										//									}

									} else {

										// Neu cau hinh khong delete file .gz sau khi extract
										// thi flag luon la true
										okDeleteGzipFile = true;

									}

								} else {

									sftpFile.note = "ERROR WHEN: EXTRACT GZIP FILE";

								}

							}

							sftpFile.retry = retryCount;
							if (okDownload && okExtract && okDeleteGzipFile) {

								sftpFile.status = 3;
								sftpFile.note = Constant.SUCCESSFUL;

								if (SftpFileDAO.update(sftpFile)) {
									sftpLastest.lastestCdrTime = fileItem.key;
									sftpLastest.changeFlag = true;

									SftpLastestDAO.merge(sftpLastest);
								}

								LOG.info("Process with file is successful: " + file.getFilename());

							} else {

								sftpFile.status = 4;

								SftpFileDAO.update(sftpFile);

								LOG.warn("Process with file is failed: " + file.getFilename());

							}

						}

					}

				}

			}
		}

	}

	private boolean hasSluFolderPath(ChannelSftp sftpChannel) {
		boolean result = false;

		try {
			sftpChannel.cd(this.inputSluFolderPath);
			result = true;
		} catch (SftpException e) {
			LOG.warn("INPUT_SLU_FOLDER isn't found: " + this.inputSluFolderPath);
		}

		return result;
	}

	@Override
	public void run() {

		List<String> result = new ArrayList<String>();

		//		String hostname = "192.168.7.232";
		//		String login = "eonerate";
		//		String password = "eonerate";
		//		String directory = "/orvol/re-rate";

		java.util.Properties config = new java.util.Properties();
		config.put("StrictHostKeyChecking", "no");

		JSch ssh = new JSch();
		Session session = null;
		Channel channel = null;
		try {
			session = ssh.getSession(this.userName, this.hostName, 22);

			session.setConfig(config);
			session.setPassword(this.password);
			session.connect();
			channel = session.openChannel("sftp");
			channel.connect();

			ChannelSftp sftpChannel = (ChannelSftp) channel;

			if (hasSluFolderPath(sftpChannel)) {
				List<String> dateFolderNames = FileUtil.getAllChildFolders(hostName, userName, password, inputSluFolderPath);

				List<ListItem> orderedDateFolderList = getOrderedFolderList(dateFolderNames);

				for (ListItem dateFolderItem : orderedDateFolderList) {

					String dateFolderName = dateFolderItem.value;

					pullCdrFile(sftpChannel, dateFolderName);

				}
			}

			//			for (SftpLastest item : sftpLastestList) {
			//
			//				if (item.changeFlag) {
			//					SftpLastestDAO.merge(item);
			//				}
			//
			//			}

			boolean runFlag = true;
			while (runFlag) {

				try {
					Thread.sleep(MainConfig.currentInstance.getScanInterval() * 1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}

				if (hasSluFolderPath(sftpChannel)) {

					String yesterday = DateTime.now().minusDays(1).toString("MMddyy");
					String today = DateTime.now().toString("MMddyy");

					pullCdrFile(sftpChannel, yesterday);
					pullCdrFile(sftpChannel, today);

				}

			}

		} catch (JSchException e) {
			e.printStackTrace();
		} catch (SftpException e) {
			e.printStackTrace();
		} finally {

			channel.disconnect();
			session.disconnect();

		}

	}

	//    @Override
	//    public void run() {
	//        try {
	//
	//            Main main = new Main();
	//            main.addRouteBuilder(new IntServerRouteBuilder(this.sluName));
	//            main.enableHangupSupport();
	//            main.run();
	//
	//        } catch (Exception ex) {
	//
	//            LOG.error("WHEN: Init Camel main; ERROR: " + ex.toString(), ex);
	//
	//        }
	//    }

}
