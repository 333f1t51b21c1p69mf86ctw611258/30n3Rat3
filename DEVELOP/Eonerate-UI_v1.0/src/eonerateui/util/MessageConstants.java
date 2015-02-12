package eonerateui.util;

public class MessageConstants {
		public interface DB_CONFIGURATION{
			public final String SUCCESS = "Update database configuration successfully!";
			public final String FAIL = "Update database configuration fail!";
		}
		
		public interface PIPELINE_CONFIGURATION{
			public final String SUCCESS = "Update pipeline configuration successfully!";
			public final String FAIL = "Update pipeline configuration fail!";
		}
		
		public interface ADAPTER_CONFIGURATION{
			public final String SUCCESS = "Update adapter configuration successfully!";
			public final String FAIL = "Update adapter configuration fail!";
		}
		
		public interface PROCESS_CONFIGURATION{
			public final String SUCCESS = "Update process configuration successfully!";
			public final String FAIL = "Update process configuration fail!";
		}
		
		public interface ECI_START{
			public final String COMPLETED = "Start Rating core commpleted!";
			public final String PORT_IN_USED = "Could not listen on port <8086>";
			public final String IO_EXCEPTION = "Start fail! IO_EXCEPTION";
		}
		
		public interface ECI_STOP{
			public final String COMPLETED = "Stop Rating core commpleted";
			public final String PROGRAM_IS_NOT_RUNNING = "Program is not running";
			public final String IO_EXCEPTION = "Stop fail! IO_EXCEPTION";
		}
		
		public interface CSV_STATUS{
			public static final String INITIALIZE = "Initialize";
			public static final String LOADING = "Loading";
			public static final String FINISHED = "Finished";
		}
		
		public interface BAD_FILE{
			public static final String NEW_FILE = "Not Done";
			public static final String SUCCESS = "Success";
			public static final String HAS_BAD = "Bad File";
		}

		public interface RC_RATING{
			public static final String CAN_NOT_STOP = "This RC rating is in progress. Can not stop it because it will demage for results!";
			public static final String RUN_IN_BACKGROUND = "Run in background was configed. This rating will be run in background. \n Click RC Rating in toolbar/menubar to show status!";
			public static final String IMMEDIATELY_OR_SCHEDULE = "Do you want to rate immediately or wait for schedule?";
			public static final String NO_RATE_FUTURE = "Can not rate for Billing cycle in future!!! Please re-select!";
			public static final String NEED_PRODUCT_OFFER = "Need to select rating RC for Product Offers or VAS services!";
			public static final String UPDATING_LOG = "Updating log...";
			public static final String UPDATED_LOG = "Updated!";
			public static final String COUNTING_SUBSCRIBERS = "Counting total subscribers...";
			public static final String NO_SUBSCRIBER_FOUND = "No subscriber found...";
			public static final String TOTAL_SUBSCRIBER = "Total: %,d subscribers";
			public static final String LOAD_TARIFF_TO_MEMORY = "Loading all RC tariffs of product version into memory...";
			public static final String LOADED_TARIFF = "Loaded!";
			public static final String DELETING_OLD_RC = "Deleting old detail rated rc of this billing cycle (it will take a moment)...";
			public static final String DELETING_AGG_RC = "Deleting old aggregated rc of this billing cycle (it will take a moment)...";
			public static final String DELETED_OLD_RC = "Deleted!";
			public static final String GETTING_TOTAL_ROWS = "Getting total rows of products, and statuses in the cycle for %,d subscribers...";
			public static final String TOTAL_ROWS = "Total: %,d rows";
			public static final String TEMP_DATA_CREATING = "Creating temporary data for rating (it will take a moment)...";
			public static final String GETTING_ALL_MTR = "Getting and loading RC tariff plans, status verions, offer verions and relative subscriber information of this billing cycle (it will take a moment)...";
			public static final String RATED_ROWS = " rows of subscribers were rated!";
			public static final String COMMITTING_RESULTS = "Committing the results in Oracle database..........";
			public static final String SQLLDR_IS_LOADING = "SQL * Loader is loading results into Oracle database..........";
			public static final String SQLLDR_DONE = "SQL*Loader for rated RC results finished. Check logs to see more detail!";
			public static final String RC_RATING_DONE = "RC rating done!";
			public static final String BULK_INSERT_DONE = "Bulk insert rated RC into database done!";
			public static final String LOADER_HAS_PROBLEMS = "There are some problems during loading time. Please check the log file to fix these problems of SQL*Loader!";
			public static final String RC_AGGREGATION = "Aggretating rated RC (it will take few moments)... ";
			public static final String RC_CONFIG_EFFECT = "Please note that parameters only take effect for RC rating next time!";
		}
		
		public interface MAIN_FORM {
			public static final String ASK_FOR_LOGOUT = "Do you want to log out from system ?";
			public static final String ASK_FOR_EXIT = "Do you want to exit eOneRate program?";
			public static final String WARNING_PROGRAM_IS_RUNNING = "Another process is currently running!\nPlease terminate this process or wait until this one is completed.";
			public static final String LANGUAGE_SUPPORT_ENGLISH_ONLY = "Version 1.0 only supports English";
		}
		
		public interface AGGREGATE_DISPATCH {
			public static final String START_PIPELINE = "Starting batch of %d pipelines for dispatching and aggregating rated CDR from CSV files...";
			public static final String START_LOADING_FILE = "Starting loading file ";
			public static final String ASK_UNSELECT_AGG = "This selected value will not set the program to run aggregate & dispatch rated CDRs automatically. Do you want to unselect it?";
			public static final String ASK_SELECT_AGG = "This selected value will set the program to run aggregate & dispatch rated CDRs automatically. Do you want to set it?";
			public static final String LOAD_RESULT_OK = "Loader for Aggragation and Dispatching has just finished. Check logs to see more detail!";
			public static final String LOAD_RESULT_NOT_OK = "Loader for Aggragation and Dispatching has just finished, but there are some errors. Check logs to see more detail!";
			public static final String MOVE_TO_DETAIL = "Dispatching detail rated CDRs...";
			public static final String AGGREGATE_START = "Aggregating rated CDRs...";
			public static final String AGGREGATE_CONFIGURED = "- Numbers of Pipeline and periodic of refresh were configured! \n";
			public static final String ALL_VIEW_CONFIGURED = "- All temporaty structure of database for the pipelines were configured! \n";
			public static final String CONFIG_NOTIFICATION = "Please note that the configurations will be with effect from next time! \n";
		}
		
		public interface LOG_MANAGEMENT {
			public static final String DELETE_SUCCESS = "All files in this directory are deleted successfully!";
			public static final String DELETE_FAIL = "Delete file unsuccessfully! \n";
			public static final String ASK_FOR_DELETE = "Do you want to delete all items in this directory";
		}

		public interface MONITORING {
			public static final String INVALID_TIME = "From Date/Time values need to be before To Date/Time values";
		}
		
		public interface RC_TARIFF{
			public static final String PRODUCT_NOT_FOUND = "Product is not existed. Please check again!";
		}
}
