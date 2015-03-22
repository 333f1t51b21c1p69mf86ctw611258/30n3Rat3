import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Vector;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class Main {

	public static void main(String[] args) throws JSchException, SftpException {

		String hostname = "192.168.7.232";
		String login = "eonerate";
		String password = "eonerate";
		String directory = "/orvol/re-rate";

		java.util.Properties config = new java.util.Properties();
		config.put("StrictHostKeyChecking", "no");

		JSch ssh = new JSch();
		Session session = ssh.getSession(login, hostname, 22);
		session.setConfig(config);
		session.setPassword(password);
		session.connect();
		Channel channel = session.openChannel("sftp");
		channel.connect();

		ChannelSftp sftp = (ChannelSftp) channel;
		sftp.cd(directory);

		Vector<ChannelSftp.LsEntry> files = sftp.ls("*");

		System.out.printf("Found %d files in dir %s%n", files.size(), directory);

		for (ChannelSftp.LsEntry file : files) {

			if (file.getAttrs().isDir()) {
				System.out.printf("Reading folder : %s, path: %s\n", file.getFilename(), file.getLongname());
				
				continue;
			}

			System.out.printf("Reading file : %s%n", file.getFilename());
			BufferedReader bis = new BufferedReader(new InputStreamReader(sftp.get(file.getFilename())));
			String line = null;

			try {

				while ((line = bis.readLine()) != null) {
					System.out.println(line);
				}

				bis.close();

			} catch (IOException e) {

				// TODO Auto-generated catch block
				e.printStackTrace();

			}
		}

		channel.disconnect();
		session.disconnect();

	}

}