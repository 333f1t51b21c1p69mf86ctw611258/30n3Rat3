package eonerateui.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;

public class Log4jUtils {

	public static String logUrl = "";
	public static String sqlloader_csv_folder = "";
	public static List<String> listUsernames = new ArrayList<String>();
	public static Properties props1 = new Properties();
	public static Properties props2 = new Properties();
	
	public static void loadProperties() throws IOException {
		String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "program.conf";
		props1.load(new FileInputStream(fileName));    
		logUrl = props1.getProperty("log_url",logUrl);
		sqlloader_csv_folder = props1.getProperty("sqlloader_csv_folder",sqlloader_csv_folder);
	}
	
	/*public static List<String> getLog() throws IOException {
			loadProperties();
			File file = new File(logUrl);
			try {
				return 
			} catch (IOException e) {
				System.out.println("java.io.FileNotFoundException: " + e.getMessage());
				return null;
			}
		}*/
	
	/**
	 * @TODO To load all username from previous input
	 * 
	 * @return
	 * 
	 * @author sonph
	 * @Date 04 Dec 2013
	 */
	public static List<String> loadUsernamesFromLog() {
		try{
		//String fileName = IConstant.ROOT_CONFIG.LOG_FOLDER_PATH + "program.log";
		String fileName = "./log/program.log";
		props2.load(new FileInputStream(fileName));
		String username = props2.getProperty("username");
		if(StringUtils.isNotEmpty(username)){
			String[] list = username.split(";");
			for(int i = 0 ; i < list.length ; i ++){
				listUsernames.add(list[i]);
			}
			listUsernames.add(0,"");
		}
		}catch(Exception e){
			System.out.println("Exception: " + e.getMessage());
		}
		return listUsernames;
	}
	
	public static void main(String args[]){
		saveUsernameToLog("e1_admin1");
	}

	public static void saveUsernameToLog(String username) {
		try {
			String fileName = "./log/program.log";
			props2.load(new FileInputStream(fileName));
			String listUsername = props2.getProperty("username");
			List<String> list = Log4jUtils.loadUsernamesFromLog();
			if(!list.contains(username)){
				listUsername = username + ";" + listUsername;	
			}else{
				listUsername = StringUtils.replace(listUsername, username, "");
				listUsername = username + ";" + listUsername;
				listUsername = StringUtils.replace(listUsername, ";;", ";");
			}
			props2.setProperty("username", listUsername);
			props2.store(new FileOutputStream(fileName), null);
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		}		
		
	}
}
