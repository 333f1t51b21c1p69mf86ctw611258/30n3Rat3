package eonerate.vnpintegration.support;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.ChannelSftp.LsEntry;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

import eonerate.vnpintegration.VnpIntServer;
import eonerate.vnpintegration.config.MainConfig;
import eonerate.vnpintegration.db.dao.SftpFileDAO;
import eonerate.vnpintegration.db.dao.SftpLastestDAO;
import eonerate.vnpintegration.entity.FileItem;
import eonerate.vnpintegration.entity.FileItemComparator;
import eonerate.vnpintegration.entity.ListItem;
import eonerate.vnpintegration.entity.ListItemComparator;
import eonerate.vnpintegration.entity.SftpFile;
import eonerate.vnpintegration.entity.SftpLastest;

/**
 *
 * @author manucian86
 */
public class IntWorker implements Runnable {

	private final Logger LOG = LoggerFactory.getLogger(IntWorker.class);

	private String hostName, userName, password, directory;

	private String sluName;
	private String inputSluFolderPath;
	public static final String DIGIT = "^\\d+$";

	private List<SftpLastest> sftpLastestList = null;

	private void initSftpLastestList() {

		this.sftpLastestList = SftpLastestDAO.getBySlu(this.sluName);

	}

	public IntWorker(String sluName) {
		this.hostName = VnpIntServer.HostName;
		this.userName = VnpIntServer.UserName;
		this.password = VnpIntServer.Password;
		this.directory = VnpIntServer.Directory;

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

	private List<FileItem> getOrderedTxtFileList(Vector<ChannelSftp.LsEntry> gzipFiles) {

		List<FileItem> result = new ArrayList<FileItem>();

		for (LsEntry fileEntry : gzipFiles) {

			FileItem item = new FileItem();
			item.value = fileEntry;

			try {
				String[] arr = fileEntry.getFilename().split("\\.");
				if (arr[1].matches(DIGIT) && arr[2].matches(DIGIT)) {
					item.key = Long.parseLong(arr[2] + arr[1]);
				} else {
					item.key = 0;
				}
			} catch (NumberFormatException ex) {
				item.key = 0;
			}

			result.add(item);

		}

		Collections.sort(result, new FileItemComparator());

		return result;

	}

	private SftpLastest getSftpLastest(/* String dateFolder */) {
		for (SftpLastest sftpLastest : sftpLastestList) {
			//			if (sftpLastest.dateFolder.equals(dateFolder)) {

			return sftpLastest;

			//			}
		}

		SftpLastest sftpLastest = new SftpLastest();
		sftpLastest.slu = this.sluName;
		//		sftpLastest.dateFolder = dateFolder;
		sftpLastest.lastestCdrTime = 0;
		sftpLastest.changeFlag = true;
		sftpLastestList.add(sftpLastest);

		return sftpLastest;
	}

	private boolean checkRegexMatcher(String fileName) {
		Pattern pattern = Pattern.compile(MainConfig.currentInstance.getInputPattern());

		Matcher matcher = pattern.matcher(fileName);
		return matcher.matches();
	}

	private void pullCdrFile(ChannelSftp sftpChannel /* , String dateFolderName */) throws SftpException {
		SftpLastest sftpLastest = getSftpLastest(/* dateFolderName */);

		String inputDateFolderPath = this.inputSluFolderPath; // + MainConfig.currentInstance.getInputOsFileSeparator() + dateFolderName;

		boolean okCd = false;
		try {
			sftpChannel.cd(inputDateFolderPath);
			okCd = true;
		} catch (SftpException e) {
			LOG.warn("INPUT_DATE_FOLDER isn't found: " + inputDateFolderPath);
		}

		if (okCd) {
			Vector<ChannelSftp.LsEntry> files = sftpChannel.ls("*.txt");
			LOG.info(String.format("* DATE FOLDER: %s; TXT FILE COUNT: %d", inputDateFolderPath, files.size()));
			List<FileItem> orderFiles = getOrderedTxtFileList(files);

			for (FileItem fileItem : orderFiles) {

				if (fileItem.key > sftpLastest.lastestCdrTime) {

					LsEntry file = fileItem.value;

					if (!file.getAttrs().isDir()) {

						String txtFileName = file.getFilename();

						if (checkRegexMatcher(txtFileName)) {
							//							LOG.info("Process gzip file: " + gzipFileName);

							SftpFile sftpFile = new SftpFile();
							sftpFile.sftpFile = txtFileName;
							sftpFile.status = 1;
							sftpFile.retry = 0;
							sftpFile.slu = this.sluName;
							sftpFile.note = Constant.PROCESSING;
							sftpFile.fileSize = file.getAttrs().getSize();

							try {

								sftpFile.seq = Integer.parseInt(txtFileName.split("\\.")[1]);

							} catch (NumberFormatException e) {
								sftpFile.seq = 0;
								LOG.error("WHEN: Convert seq to number, fileName: " + txtFileName + "; ERROR: " + e.toString());
							}

							// Neu create SftpFile thanh cong
							if (SftpFileDAO.create(sftpFile)) {

								String inputGzipFilePath = inputDateFolderPath + MainConfig.currentInstance.getInputOsFileSeparator() + txtFileName;

								String outputFolderPath = MainConfig.currentInstance.getDestFolderPath(); // + Constant.OUTPUT_OS_FILE_SEPARATOR + sluName + Constant.OUTPUT_OS_FILE_SEPARATOR + dateFolderName;

								// Tao output folder neu chua ton tai
								FileUtil.createFolderIfNotExist(outputFolderPath);

								int retryCount = 0;

								boolean okDownload = false;
								//							boolean okExtract = false;
								//							boolean okDeleteGzipFile = false;

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

								//							if (okDownload) {
								//
								//								String outputGzipFilePath = outputFolderPath + Constant.OUTPUT_OS_FILE_SEPARATOR + gzipFileName;
								//								// Neu can extract ra cung folder voi file .gz
								//								//								String outputCdrFilePath = outputFolderPath + Constant.OUTPUT_OS_FILE_SEPARATOR + gzipFileName.substring(0, gzipFileName.length() - 3);
								//								//String outputCdrFilePath = MainConfig.currentInstance.getDestFolderPath() + Constant.OUTPUT_OS_FILE_SEPARATOR + gzipFileName.substring(0, gzipFileName.length() - 3);
								//
								//								String extCdrFilePath = MainConfig.currentInstance.getExtFolderPath() + Constant.OUTPUT_OS_FILE_SEPARATOR + gzipFileName.substring(0, gzipFileName.length() - 3);
								//								okExtract = true; //FileUtil.extractGzipFile(outputGzipFilePath, extCdrFilePath);
								//
								//								if (okExtract) {
								//
								//									if (MainConfig.currentInstance.isDeleteGzipFile()) {
								//
								//										File outputGzipFile = new File(outputGzipFilePath);
								//										okDeleteGzipFile = outputGzipFile.delete();
								//
								//										if (!okDeleteGzipFile) {
								//
								//											sftpFile.note = "ERROR WHEN: DELETE GZIP FILE";
								//
								//										}
								//
								//										//									try {
								//										//										
								//										//									} catch (IOException e) {
								//										//
								//										//										sftpFile.desc = "ERROR WHEN: DELETE GZIP FILE; " + e.toString();
								//										//
								//										//										LOG.error("WHEN: Delete Output Gzip file: " + outputGzipFilePath);
								//										//
								//										//									}
								//
								//									} else {
								//
								//										// Neu cau hinh khong delete file .gz sau khi extract
								//										// thi flag luon la true
								//										okDeleteGzipFile = true;
								//
								//									}
								//
								//								} else {
								//
								//									sftpFile.note = "ERROR WHEN: EXTRACT GZIP FILE";
								//
								//								}
								//
								//							}

								sftpFile.retry = retryCount;
								if (okDownload/* && okExtract && okDeleteGzipFile */) {

									sftpFile.status = 3;
									sftpFile.note = Constant.SUCCESSFUL;

									long tmpLastestCdrTime = sftpLastest.lastestCdrTime;
									boolean tmpChangeFlag = sftpLastest.changeFlag;

									sftpLastest.lastestCdrTime = fileItem.key;
									sftpLastest.changeFlag = true;

									//									if (SftpFileDAO.update(sftpFile)) {
									//										sftpLastest.lastestCdrTime = fileItem.key;
									//										sftpLastest.changeFlag = true;
									//
									//										SftpLastestDAO.merge(sftpLastest);
									//									}

									if (SftpFileDAO.updateWithLastest(sftpFile, sftpLastest)) {
										LOG.info("Process with file is successful: " + file.getFilename());
									} else {
										sftpLastest.lastestCdrTime = tmpLastestCdrTime;
										sftpLastest.changeFlag = tmpChangeFlag;

										LOG.warn("Process with file is failed: " + file.getFilename());
									}

								} else {

									sftpFile.status = 4;

									SftpFileDAO.update(sftpFile);

									LOG.warn("Process with file is failed: " + file.getFilename());

								}
							}
						} else {
							LOG.warn("FileName isn't valid, fileName: " + txtFileName);
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

		boolean trueFlag = true;
		int sshCount = 0;
		while (trueFlag) {
			try {
				session = ssh.getSession(this.userName, this.hostName, 22);

				session.setConfig(config);
				session.setPassword(this.password);

				sshCount++;
				session.setTimeout(60000);
				session.connect();

				break;
			} catch (JSchException jsche) {
				System.err.println("Couldn't connect by SSH => " + jsche.getMessage());

				if ((jsche.getMessage().equals("connection is closed by foreign host") ||
						jsche.getMessage().contains("Connection reset")) && sshCount <= 10) {
					System.out.println("Retry to get SFTP Connection; Retry count: " + sshCount + " <= 10");
					try {
						Thread.sleep(3000);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				} else {
					System.exit(1);
				}

			}
		}

		try {

			channel = session.openChannel("sftp");
			channel.connect();

			ChannelSftp sftpChannel = (ChannelSftp) channel;

			//			if (/* !MainConfig.currentInstance.isOnlyToday() && */hasSluFolderPath(sftpChannel)) {
			//				List<String> dateFolderNames = FileUtil.getAllChildFolders(hostName, userName, password, inputSluFolderPath);
			//
			//				List<ListItem> orderedDateFolderList = getOrderedFolderList(dateFolderNames);
			//
			//				for (ListItem dateFolderItem : orderedDateFolderList) {
			//
			//					String dateFolderName = dateFolderItem.value;
			//
			//					pullCdrFile(sftpChannel, dateFolderName);
			//
			//				}
			//			}

			//			for (SftpLastest item : sftpLastestList) {
			//
			//				if (item.changeFlag) {
			//					SftpLastestDAO.merge(item);
			//				}
			//
			//			}

			boolean runFlag = true;
			while (runFlag) {

				if (hasSluFolderPath(sftpChannel)) {

					//					String yesterday = DateTime.now().minusDays(1).toString("MMddyy");
					//					String today = DateTime.now().toString("MMddyy");

					pullCdrFile(sftpChannel /*, yesterday */);
					//					pullCdrFile(sftpChannel, today);

				}

				try {
					Thread.sleep(MainConfig.currentInstance.getScanInterval() * 1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
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
