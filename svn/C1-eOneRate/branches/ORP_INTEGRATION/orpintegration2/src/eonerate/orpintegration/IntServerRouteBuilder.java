package eonerate.orpintegration;

import java.util.List;

import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.properties.PropertiesComponent;
import org.apache.camel.model.dataformat.ZipFileDataFormat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.SftpException;

import eonerate.orpintegration.config.MainConfig;
import eonerate.orpintegration.support.FileUtil;

public class IntServerRouteBuilder extends RouteBuilder {

	private final Logger LOG = LoggerFactory.getLogger(IntServerRouteBuilder.class);

	private String hostName, userName, password, directory;

	private String sluName;
	private String sluPath;

	public IntServerRouteBuilder(String sluName) {
		this.hostName = IntServer.HostName;
		this.userName = IntServer.UserName;
		this.password = IntServer.Password;
		this.directory = IntServer.Directory;

		this.sluName = sluName;
		this.sluPath = this.directory + MainConfig.currentInstance.getSrcOsFileSeparator() + sluName;
	}

	@Override
	public void configure() {
		// configure properties component
		PropertiesComponent pc = getContext().getComponent("properties", PropertiesComponent.class);
		pc.setLocation("classpath:ftp.properties");

		// lets shutdown faster in case of in-flight messages stack up
		getContext().getShutdownStrategy().setTimeout(10);

		ZipFileDataFormat zipFile = new ZipFileDataFormat();
		zipFile.setUsingIterator(true);

		try {
			List<String> dateFolders = FileUtil.getAllChildFolders(hostName, userName, password, sluPath);

			for (String dateFolder : dateFolders) {
				String sftpClient = "sftp://" + this.hostName + ":22/" + this.sluPath + MainConfig.currentInstance.getSrcOsFileSeparator() + dateFolder + "?username=" + this.userName + "&password=" + this.password + "&preferredAuthentications=publickey,password";

				String sftpServer = sftpClient + "&include=IPbill.*.gz&sortBy=file:name&delay=5s&noop=true&streamDownload=true&stepwise=false";

				String sftpTarget = "file://D:/Download/" + sluName + MainConfig.currentInstance.getSrcOsFileSeparator() + dateFolder + "?fileExist=Ignore";

				System.out.println(sftpServer);

				from(sftpServer)
						//						.unmarshal().gzip()						
						.onException(Exception.class)
						.handled(true)
						//						.process(new Processor() {
						//							public void process(Exchange msg) {
						//								File file = msg.getIn().getBody(File.class);
						//								LOG.info("################## Processing file: " + msg.getProperty(Exchange.FILE_NAME));
						//							}
						//						})
						.log("Exception occurred: ${exception.stacktrace}")
						.end()
						//
						//.filter().simple("${file:ext} == 'zip'")
						//                    .split( new ZipSplitter())
						//                    .streaming()
						//                .parallelProcessing()
						//
						.to(sftpTarget)
						//						.to("{{sftp.target}}&fileName=${file:name.noext}")
						//                .to("{{sftp.target}}")
						.log("Downloaded file ${file:name} with size ${file:size} complete.");

				//		from("{{sftp.server}}")
				//				.unmarshal().gzip()
				//				.throwException(new Exception())
				//				.onException(Exception.class)				
				//				.handled(true)
				//				.log("Exception occurred : ${exception.stacktrace}")
				//				.end()
				//				//
				//				//.filter().simple("${file:ext} == 'zip'")
				//				//                    .split( new ZipSplitter())
				//				//                    .streaming()
				//				//                .parallelProcessing()
				//				//
				//				.to("{{sftp.target}}&fileName=${file:name.noext}")
				//				//                .to("{{sftp.target}}")
				//				.log("Downloaded file ${file:name} with size ${file:size} complete.");

				//        // use system out so it stand out
				//        System.out.println("*********************************************************************************");
				//        System.out.println("Camel will route files from the FTP server: "
				//                + getContext().resolvePropertyPlaceholders("{{sftp.server}}") + " to the target/download directory.");
				//        System.out.println("You can configure the location of the ftp server in the src/main/resources/ftp.properties file.");
				//        System.out.println("Use ctrl + c to stop this application.");
				//        System.out.println("*********************************************************************************");
			}

		} catch (JSchException | SftpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
