package eonerateui.db;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;

import org.apache.log4j.Logger;

import eonerateui.db.pool.DBconnect;
import eonerateui.util.ProgramConfig;

public class MainInforDAO {
	private static Logger logger=Logger.getLogger("MainInforDAO");
	public static String[] getValuesInfor() throws SQLException, IOException {
		String[] rowValues = {"","","","","","","",""};

		DBconnect db= new DBconnect();
		String schemaData = db.getDbconfig().getDb_data_schema();
		ProgramConfig pgConfig = new ProgramConfig();
		
		String[] sql = {"SELECT count(*) count FROM " + schemaData + "cdr_record_header WHERE convert_time LIKE sysdate",
						"SELECT count(*) count FROM " + schemaData + "cdr_record_header WHERE convert_time LIKE sysdate AND checksum_valid = '0'",
						"SELECT count(*) count FROM " + schemaData + "cdr_record_header WHERE convert_time LIKE sysdate AND checksum_valid <> '0'",
						"SELECT count(*) count FROM " + schemaData + "rated_cdr WHERE created_time LIKE sysdate",
						"SELECT count(*) count FROM " + schemaData + "rated_cdr WHERE created_time LIKE sysdate AND cdr_type =" + pgConfig.getVoiceCdrType(),
						"SELECT count(*) count FROM " + schemaData + "rated_cdr WHERE created_time LIKE sysdate AND cdr_type =" + pgConfig.getSMSCdrType(),
						"SELECT count(*) count FROM " + schemaData + "rated_cdr WHERE created_time LIKE sysdate AND cdr_type =" + pgConfig.getDataCdrType(),
						"SELECT count(*) count FROM " + schemaData + "rated_rc WHERE rate_time LIKE sysdate"};
		
		Statement st = db.createStatement();
		ResultSet rs;
		DecimalFormat df = new DecimalFormat("#,###");
		
		for (int i=0; i<sql.length; i++) {
			rs = db.Select(sql[i], true, st);
			if (rs.next()) {
				rowValues[i] = df.format(rs.getInt("count"));
			}
			rs.close();
		}
		st.close();
		db.close();
		pgConfig = null;
		
		return rowValues;
	}
	
	public static void clearRateTimeLog() {
		try {
			DBconnect db= new DBconnect();
			db.Update("TRUNCATE TABLE " + db.getDbconfig().getDb_data_schema() + "rc_log");
			db.close();
		} catch (SQLException e1) {
			logger.error("SQLException", e1);
		}
	}

	public static String[] getLogTimesRC() {
		String[] returnValue = {"",""};
		try {
			DBconnect db= new DBconnect();
			Statement st = db.createStatement();
			ResultSet rs = db.Select("SELECT to_char(rate_time, 'HH24:MI:SS') time, insert_type FROM " + db.getDbconfig().getDb_data_schema() + "rc_log WHERE rate_time LIKE sysdate ORDER BY rate_time", true, st);

			int count = 0;
			String sRow ="";
			while (rs.next()) {
				count++;

				String insertTyppe = rs.getString("insert_type");
				if (insertTyppe.equals("0"))
					insertTyppe = "BulkInsert";
				else
					insertTyppe = "Loader";
				
				sRow = sRow + rs.getString("time") + "  |  " + insertTyppe + "\n";
			}
			
			String timeToday = "Rated today: " + Integer.toString(count) + " time(s)";
	
			rs.close();
			st.close();
			db.close();
			
			returnValue[0] = sRow; 
			returnValue[1] = timeToday; 

		} catch (SQLException e) {
			logger.error("SQLException", e);
		}
		return returnValue;
	}

}

