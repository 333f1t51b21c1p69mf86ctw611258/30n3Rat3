package eonerate.cdrintegration.config;

import java.io.FileNotFoundException;
import java.io.FileReader;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

public class XmlRepo {

	public static MainConfig readMainConfig() {

		XStream xstream = new XStream(new DomDriver()); // does not require XPP3 library

		xstream.alias("config", MainConfig.class);

		FileReader fileReader = null;		
		String configFilePath = System.getProperty("user.home") + "/deploy/cdrintegration/config/config.xml";
		
		try {
			
			fileReader = new FileReader(configFilePath);
		} catch (FileNotFoundException e) {
			System.err.println(configFilePath + " file isn't found");
			return null;
		}

		MainConfig mainConfig = (MainConfig) xstream.fromXML(fileReader);

		return mainConfig;

	}

	//	public static void writeMainConfig() {
	//
	//		XStream xstream = new XStream(new DomDriver()); // does not require XPP3 library
	//
	//		xstream.alias("config", MainConfig.class);
	//
	//		FileReader fileReader = null;
	//		try {
	//			fileReader = new FileReader("config.xml");
	//		} catch (FileNotFoundException e) {
	//			System.err.println("config.xml file isn't found");
	//		}
	//
	//		MainConfig mainConfig = (MainConfig) xstream.fromXML(fileReader);
	//
	//	}

}
