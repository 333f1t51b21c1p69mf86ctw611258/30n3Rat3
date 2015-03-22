package eonerateui.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class ProgramConfig {

	public static String getProperties(String config, String defaultValue) throws IOException {
		String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "program.conf";
		Properties props = new Properties();
		props.load(new FileInputStream(fileName));    
		String returnValue = props.getProperty(config, defaultValue);
		props.clear();
		
		return returnValue;
	}
	
	public static String getRC_CtlURL() throws IOException {
		return getProperties("rc_ctl_url","");
	}

	public static String getUsageCtlPath() throws IOException {
		return getProperties("usage_ctl_path","");
	}

	public static String getRC_LogURL() throws IOException {
		return getProperties("rc_log_url", "");
	}

	public static String getUsageLogPath() throws IOException {
		return getProperties("usage_log_path", "");
	}

	public static String getUsageDataPath() throws IOException {
		return getProperties("usage_data_path", "");
	}

	public static String getRC_BadURL() throws IOException {
		return getProperties("rc_bad_url", "");
	}

	public static String getUsageBadPath() throws IOException {
		return getProperties("usage_bad_path", "");
	}

	public String getVoiceCdrType() throws IOException {
		return getProperties("voice_cdr_type", "");
	}

	public String getSMSCdrType() throws IOException {
		return getProperties("sms_cdr_type", "");
	}

	public String getDataCdrType() throws IOException {
		return getProperties("data_cdr_type", "");
	}
	
	public static String getVasService() throws IOException {
		return getProperties("vas_service", "0");
	}

	public static String getConfigFile() throws IOException {
		return getProperties("config_file", "");
	}
	
	public static String getEncryptedKey() throws IOException{
		return getProperties("encrypted_key", "");
	}
}
