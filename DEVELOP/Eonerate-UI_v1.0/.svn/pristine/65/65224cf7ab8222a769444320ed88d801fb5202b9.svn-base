package eonerateui.util;


public class IConstant {
	public interface XML_TAG{

		/*
		 * tag for pipeline config
		 */
		public static final String PipelineList = "PipelineList";
		public static final String eOneRatePipeline = "eOneRatePipeline";
		public static final String Active = "Active";
		
		/*
		 * tag for database config
		 */
		public static final String Resource = "Resource";
		public static final String DataSourceFactory = "DataSourceFactory";
		public static final String DataSource = "DataSource";
		public static final String eOneRateDB = "eOneRateDB";
		public static final String db_url = "db_url";
		public static final String username = "username";
		public static final String password = "password";
		
		/*
		 * tag for input adapter config
		 */
		public static final String InputAdapter = "InputAdapter";
		public static final String DBInpAdapter = "DBInpAdapter";
		public static final String ValidateStatement = "ValidateStatement";
		public static final String RecordCountStatement = "RecordCountStatement";
		public static final String InitStatement = "InitStatement";
		public static final String CommitStatement = "CommitStatement";
		public static final String RollbackStatement = "RollbackStatement";
		public static final String RecordSelectStatement = "RecordSelectStatement";
		public static final String OutputAdapter = "OutputAdapter";
		public static final String DBOutputAdapter = "DBOutputAdapter";
		
		
		/*
		 * tag for processing adapter config
		 */
		public static final String Process = "Process";
		
	}
	
	public interface USER_ROLE{
		public static final String VIEWER = "viewer";			// Only view the content (log, select query DB)
		public static final String MONITOR = "monitor";			// include viewer; can start,stop ECI, configure Openrate xml
		public static final String RATING_RC = "rating_rc";		// include viewer; configure rating RC, can start, stop rating RC
		public static final String ADMIN = "super_admin";		// Fully function
	}
	
	public interface USER_ROLE_CODE{
		public static final int ADMIN = 1;
		public static final int MONITOR = 2;
		public static final int RATING_RC = 3;
		public static final int VIEWER = 4;		
	}
	
	public static interface ROOT_CONFIG {
		public static final String HOME_DIR = System.getProperty("user.dir");
		public static final String SEPARATOR = System.getProperty("file.separator");
		//public static final String PROJECT = "eonerate";
		//public static final String MODULE = "eonerate_ui";
		public static final String CONFIG_FOLDER = "config";
		public static final String LOG_FOLDER = "log";
		public static final String CONFIG_FOLDER_PATH = HOME_DIR + SEPARATOR + CONFIG_FOLDER + SEPARATOR;
		public static final String LOG_FOLDER_PATH = HOME_DIR + SEPARATOR + LOG_FOLDER + SEPARATOR;
	}
	
}


