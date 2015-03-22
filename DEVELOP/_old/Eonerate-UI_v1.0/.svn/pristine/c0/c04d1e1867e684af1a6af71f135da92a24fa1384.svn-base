package eonerateui.db.pool;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import eonerateui.util.IConstant;

public class DBConfig {

	/**
	 * @param args
	 */
	public static boolean databaseEnabled = true;
	private static String db_driver = "";
	private static String db_url = "";
	private static String db_schema = "";
	private static String db_user = "";
	private static String db_pass = "";
	private static String db_data_schema = "";
	
	public static boolean ValidateConnection = true;

	public DBConfig() {
		try {
			loadProperties();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void loadProperties() throws IOException {
		String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "database.conf";
		Properties props = new Properties();
		props.load(new FileInputStream(fileName));    
		db_driver = props.getProperty("db_driver", db_driver);
		db_url = props.getProperty("db_url", db_url);
		db_schema = props.getProperty("db_schema", db_schema);
		db_user = props.getProperty("db_user", db_user);
		db_pass = props.getProperty("db_pass", db_pass);
		db_data_schema = props.getProperty("db_data_schema", db_data_schema);
	}

	public String getDb_driver() {
		return db_driver;
	}

	public String getDb_url() {
		return db_url;
	}

	public String getDb_schema() {
		return db_schema + ".";
	}

	public String getDb_data_schema() {
		return db_data_schema + ".";
	}

	public String getDb_user() {
		return db_user;
	}

	public String getDb_pass() {
		return db_pass;
	}

	public void setDb_driver(String db_driver) {
		DBConfig.db_driver = db_driver;
	}

	public void setDb_url(String db_url) {
		DBConfig.db_url = db_url;
	}

	public void setDb_schema(String db_schema) {
		DBConfig.db_schema = db_schema;
	}

	public void setDb_user(String db_user) {
		DBConfig.db_user = db_user;
	}

	public void setDb_pass(String db_pass) {
		DBConfig.db_pass = db_pass;
	}
}
