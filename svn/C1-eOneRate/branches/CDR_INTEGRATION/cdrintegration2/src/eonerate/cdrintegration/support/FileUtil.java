package eonerate.cdrintegration.support;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.zip.GZIPInputStream;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class FileUtil {

	private static final Logger LOG = LoggerFactory.getLogger(FileUtil.class);

	public static List<String> getAllChildFolders(String hostName, String userName, String password, String Directory) throws JSchException, SftpException {

		List<String> result = new ArrayList<String>();

		//		String hostname = "192.168.7.232";
		//		String login = "eonerate";
		//		String password = "eonerate";
		//		String directory = "/orvol/re-rate";

		java.util.Properties config = new java.util.Properties();
		config.put("StrictHostKeyChecking", "no");

		JSch ssh = new JSch();
		Session session = ssh.getSession(userName, hostName, 22);
		session.setConfig(config);
		session.setPassword(password);
		session.connect();
		Channel channel = session.openChannel("sftp");
		channel.connect();

		ChannelSftp sftp = (ChannelSftp) channel;
		sftp.cd(Directory);

		Vector<ChannelSftp.LsEntry> files = sftp.ls("*");

		LOG.info("Current folder: " + Directory + "; Child count: " + files.size());

		for (ChannelSftp.LsEntry file : files) {

			if (file.getAttrs().isDir()) {

				result.add(file.getFilename());

				//				System.out.printf("Reading folder : %s, path: %s\n", file.getFilename(), file.getLongname());
			}

			//			System.out.printf("Reading file : %s%n", file.getFilename());
			//			BufferedReader bis = new BufferedReader(new InputStreamReader(sftp.get(file.getFilename())));
			//			String line = null;
			//
			//			try {
			//
			//				while ((line = bis.readLine()) != null) {
			//					System.out.println(line);
			//				}
			//
			//				bis.close();
			//
			//			} catch (IOException e) {
			//
			//				// TODO Auto-generated catch block
			//				e.printStackTrace();
			//
			//			}

		}

		channel.disconnect();
		session.disconnect();

		return result;

	}

	public static List<String> getAllChildFiles(String hostName, String userName, String password, String Directory) throws JSchException, SftpException {

		List<String> result = new ArrayList<String>();

		//		String hostname = "192.168.7.232";
		//		String login = "eonerate";
		//		String password = "eonerate";
		//		String directory = "/orvol/re-rate";

		java.util.Properties config = new java.util.Properties();
		config.put("StrictHostKeyChecking", "no");

		JSch ssh = new JSch();
		Session session = ssh.getSession(userName, hostName, 22);
		session.setConfig(config);
		session.setPassword(password);
		session.connect();
		Channel channel = session.openChannel("sftp");
		channel.connect();

		ChannelSftp sftp = (ChannelSftp) channel;
		sftp.cd(Directory);

		Vector<ChannelSftp.LsEntry> files = sftp.ls("*");

		LOG.info("Current folder: " + Directory + "; Child count: " + files.size());

		for (ChannelSftp.LsEntry file : files) {

			if (!file.getAttrs().isDir()) {

				result.add(file.getFilename());

				//				System.out.printf("Reading folder : %s, path: %s\n", file.getFilename(), file.getLongname());
			}

			//			System.out.printf("Reading file : %s%n", file.getFilename());
			//			BufferedReader bis = new BufferedReader(new InputStreamReader(sftp.get(file.getFilename())));
			//			String line = null;
			//
			//			try {
			//
			//				while ((line = bis.readLine()) != null) {
			//					System.out.println(line);
			//				}
			//
			//				bis.close();
			//
			//			} catch (IOException e) {
			//
			//				// TODO Auto-generated catch block
			//				e.printStackTrace();
			//
			//			}

		}

		channel.disconnect();
		session.disconnect();

		return result;

	}

	public static boolean extractGzipFile(String sourceFilePath, String destFilePath) {

		boolean result = false;

		try {

			//To Uncompress GZip File Contents we need to open the gzip file.....

			//			String inFilename = args[0];
			//			System.out.println("Opening the gzip file.......................... :  opened");

			GZIPInputStream gzipInputStream = null;
			FileInputStream fileInputStream = null;
			gzipInputStream = new GZIPInputStream(new FileInputStream(sourceFilePath));

			//			System.out.println("Opening the output file............. : opened");

			//				String outFilename = inFilename + ".pdf";
			OutputStream out = new FileOutputStream(destFilePath);

			//			System.out.println("Transferring bytes from the compressed file to the output file........: Transfer successful");
			byte[] buf = new byte[1024]; //size can be changed according to programmer's need.
			int len;
			while ((len = gzipInputStream.read(buf)) > 0) {
				out.write(buf, 0, len);
			}

			//			System.out.println("The file and stream is ......closing.......... : closed");
			gzipInputStream.close();
			out.close();

			result = true;

		} catch (IOException e) {

			//			System.out.println("Exception has been thrown" + e);

		}

		return result;

	}

	public static boolean createFolderIfNotExist(String folderPath) {

		boolean result = false;
		
		File dir = new File(folderPath);

		// if the directory does not exist, create it
		if (!dir.exists()) {
			LOG.info("Output folder is creating: " + folderPath);

			//			try {
			//				theDir.mkdir();
			//				result = true;
			//			} catch (SecurityException se) {
			//				//handle it
			//			}

			try {
				FileUtils.forceMkdir(dir);

				result = true;
			} catch (IOException e) {
				result = false;

				LOG.error("WHEN: Create ouput folder: " + folderPath, e);
			}

			if (result) {
				LOG.info("Output folder has created: " + folderPath);
			}
		} else {
			result = true;
		}

		return result;
		
	}

}
