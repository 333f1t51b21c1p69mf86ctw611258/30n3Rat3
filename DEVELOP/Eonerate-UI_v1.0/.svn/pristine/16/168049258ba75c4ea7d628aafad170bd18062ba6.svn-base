package eci.services;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;

import eonerateui.util.IConstant;
 
public class TestWS {
	private static Logger logger=Logger.getLogger("TestWS");
	private static String eci_ws_url;
	private static EciGwServicesSoapBindingStub service; 
	public TestWS(){
		try {
			loadProperties();
			service = new EciGwServicesSoapBindingStub(new URL(eci_ws_url + "?wsdl"),null);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void loadProperties() throws IOException {
		Properties props = new Properties();
		String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "program.conf";
		logger.info(fileName);
		props.load(new FileInputStream(fileName));    
		eci_ws_url = props.getProperty("eci_ws_url", eci_ws_url);
		logger.info(eci_ws_url);
	}
	
	public int startECI(){
		try {
			if(checkConnection())
			return service.startECI();
			else return -1;
		} catch (RemoteException e) {
			//e.printStackTrace();
			return -1;
		}
	}
	
	public int stopECI(){
		try {
			if(checkConnection()) return service.stopECI();
			else return -1;
		} catch (RemoteException e) {
			//e.printStackTrace();
			return -1;
		}
	}
	
	public int checkStatus(){
		try {
			if(checkConnection()) return service.checkStatus();
			else return -1;
		} catch (RemoteException e) {
			//e.printStackTrace();
			return -1;
		}
	}
	
	public List<String> getLog(){
		List<String> listLog = new ArrayList<String>();
		try {
			if(checkConnection()) {
				String log = service.getLog();
				if(log != null){
					String[] a = log.split("\n");
					listLog = Arrays.asList(a);
				}
			}
		} catch (RemoteException e) {
			//logger.error("RemoteException", e);
		}
		return listLog;
	}

	private Boolean checkConnection(){
		try {
			service.checkConnection();
			return true;
		} catch (RemoteException e) {
			logger.warn("[Eci- Monitoring] Cannot connected to web services!");
			return false;
		}
	}
	
	public static void main(String args[]){
		try {
			loadProperties();
		} catch (IOException e) {
			logger.error("IOException", e);
		}
	}
}
