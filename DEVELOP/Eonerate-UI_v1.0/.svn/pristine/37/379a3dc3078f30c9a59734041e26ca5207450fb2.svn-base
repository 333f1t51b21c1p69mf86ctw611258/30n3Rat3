package eonerateui.util;

public class CodeConstants {
		
		public interface COMMON{
			public final int SUCCESS = 0;
			public final int FAIL = -1;
			public final int OTHER_EXCEPTION = -2;
		}
		
		public interface DATABASE{
			public final int FILE_NOT_FOUND = -11;
			public final int CLASS_NOT_FOUND = -12;
			public final int SQL_EXCEPTION = -13;	
		}
		
		public interface ECI_START{
			public final int COMPLETED = 0;
			public final int PORT_IN_USED = -21;
			public final int IO_EXCEPTION = -22;
		}
		
		public interface ECI_STOP{
			public final int COMPLETED = 0;
			public final int PROGRAM_IS_NOT_RUNNING = -31;
			public final int IO_EXCEPTION = -32; 
		}
		
		public interface CSV_STATUS_CODE{
			public static final Integer INITIALIZE = 0;
			public static final Integer LOADING = 1;
			public static final Integer FINISHED = 2;
		}

		public interface CSV_BADFILE_CODE{
			public static final Integer NEW_FILE = 0;
			public static final Integer HAS_BAD = 1;
			public static final Integer SUCCESS = 2;
		}
		
		public interface RC_RATING{
			public static final int PRORATE 	 = 1; 	//prorate, RC = RC / Day_of_month * Number_of_day
			public static final int DIV_FIX_DAY  = 2; 	//same prograte, but RC = RC / (fix_day) * Number_of_day. Fix_day is tariff_value of RC_tariff
			public static final int PERCENT 	 = 3; 	//rated by percent, RC = RC * percent. Percent is tariff_value of RC_tariff
			public static final int FIX_AMOUNT   = 4; 	//fix amount of RC. RC = tariff_value of RC_tariff
			public static final int RUN_BACKGROUND = 1;
			public static final int RUN_MANUAL 	   = 0;
			public static final int AGGREGATE_WHEN_DONE = 1;
		}

		public interface RATING_MONITOR{
			public static final Integer JVM = 0;
			public static final Integer PIPELINE = 1;
		}
}

