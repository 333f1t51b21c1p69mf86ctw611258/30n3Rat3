package eonerate.cdrintegration;

import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.properties.PropertiesComponent;
import org.apache.camel.model.dataformat.ZipFileDataFormat;

public class IntServerRouteBuilder extends RouteBuilder {

	@Override
	public void configure() throws Exception {
		// configure properties component
		PropertiesComponent pc = getContext().getComponent("properties", PropertiesComponent.class);
		pc.setLocation("classpath:ftp.properties");

		// lets shutdown faster in case of in-flight messages stack up
		getContext().getShutdownStrategy().setTimeout(10);

		ZipFileDataFormat zipFile = new ZipFileDataFormat();
		zipFile.setUsingIterator(true);

		from("{{sftp.server}}")
				.unmarshal().gzip()
				.onException(Exception.class)
				.handled(true)
				.log("Exception occurred: ${exception.stacktrace}")
				.end()
				//
				//.filter().simple("${file:ext} == 'zip'")                
				//                    .split( new ZipSplitter())
				//                    .streaming()
				//                .parallelProcessing()
				//
				.to("{{sftp.target}}")
				//                .to("{{sftp.target}}")
				.log("Downloaded file ${file:name} with size ${file:size} complete.");

		//        // use system out so it stand out
		//        System.out.println("*********************************************************************************");
		//        System.out.println("Camel will route files from the FTP server: "
		//                + getContext().resolvePropertyPlaceholders("{{sftp.server}}") + " to the target/download directory.");
		//        System.out.println("You can configure the location of the ftp server in the src/main/resources/ftp.properties file.");
		//        System.out.println("Use ctrl + c to stop this application.");
		//        System.out.println("*********************************************************************************");
	}
}
