package eonerateui.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import org.apache.log4j.Logger;

import eonerateui.db.pool.DBconnect;
import eonerateui.util.CodeConstants;

public class MonitoringDAO {
	private static Logger logger=Logger.getLogger("MonitoringDAO");
	public static Map<String, Map<String, Integer>> getInforCSV(String fromDateTime, String toDateTime) {
		Map<String, Map<String, Integer>> treeMapCSV = null;
		try {
			Map<String, Map<String, Integer>> hashCSVInfor = new HashMap<String, Map<String, Integer>>();

			DBconnect db = new DBconnect();
			Statement st = db.createStatement();
			String sql = "SELECT count(1) totalCDR, jvm_name, pipeline_name " +
						 "FROM " + db.getDbconfig().getDb_data_schema() + "rated_csv_file " +
						 "WHERE created_time BETWEEN to_date('" + fromDateTime + "','dd/MM/yyyy HH24:MI:SS') AND to_date('" + toDateTime + "','dd/MM/yyyy HH24:MI:SS') " +
						 "GROUP BY jvm_name, pipeline_name " +
						 "ORDER BY jvm_name, pipeline_name";
			
			ResultSet rs = db.Select(sql, true, st);
			while(rs.next()){
				Integer totalCDR = rs.getInt("totalCDR");
				String jvmName = rs.getString("jvm_name");
				String pipelineName = rs.getString("pipeline_name");
				
				if (!hashCSVInfor.containsKey(jvmName)) {
					Map<String, Integer> mapPipeline = new HashMap<String, Integer>(); 
					hashCSVInfor.put(jvmName, mapPipeline);
				}
				hashCSVInfor.get(jvmName).put(pipelineName, totalCDR);
			}
			
			Map<String, Map<String, Integer>> hashCSVInforTemp = new HashMap<String, Map<String, Integer>>();
			for (Entry<String, Map<String, Integer>> entryCSV : hashCSVInfor.entrySet()) {
		    	Map<String, Integer> mapPipelineTemp = new HashMap<String, Integer>(); 
			    for (Map.Entry<String, Integer> entryPipelineCdr : entryCSV.getValue().entrySet()) {
			    	mapPipelineTemp.put(entryPipelineCdr.getKey(), entryPipelineCdr.getValue());
			    }
			    
		    	Map<String, Integer> treePipeline = new TreeMap<String, Integer>(mapPipelineTemp);
		    	hashCSVInforTemp.put(entryCSV.getKey(), treePipeline);
			}

			treeMapCSV = new TreeMap<String, Map<String, Integer>>(hashCSVInforTemp);
			
			st.close();
			rs.close();
			db.close();
			
		} catch (SQLException e) {
			logger.error("SQLException", e);
		}

		return treeMapCSV;
	}
	
	public static List<String> getListOfCombo(int flag) {
		List<String> listOfCombo = new ArrayList<String>();
		
		try {
			String fieldName = (flag == CodeConstants.RATING_MONITOR.JVM)? "jvm_name" : "pipeline_name";
			
			DBconnect db = new DBconnect();
			Statement st = db.createStatement();
			String sql = "SELECT distinct " + fieldName + " FROM " + db.getDbconfig().getDb_data_schema() + "rated_csv_file ORDER BY " + fieldName;
			
			ResultSet rs = db.Select(sql, true, st);
			while(rs.next()){
				listOfCombo.add(rs.getString(fieldName));
			}
						
			st.close();
			rs.close();
			db.close();
			
		} catch (SQLException e) {
			logger.error("SQLException", e);
		}

		return listOfCombo;
	}
	
	public static HashMap<String, Integer> getScoreValueOfPipeline(String startTime, String endTime, String jvmName, String pipelineName) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();		
		try {
			DBconnect db = new DBconnect();
			Statement st = db.createStatement();
			String sql = "SELECT to_date(to_char(created_time, 'ddMMyyyyHH24')||'0000','ddMMyyyyHH24MISS') time, count(*) score  FROM " + db.getDbconfig().getDb_data_schema() + "rated_csv_file " +
					 	 "WHERE created_time BETWEEN to_date('" + startTime + "','ddMMyyyyHH24MISS') AND to_date('" + endTime + "','ddMMyyyyHH24MISS')"	+
					 	 "	AND jvm_name ='" + jvmName + "' AND pipeline_name ='" + pipelineName + "' " +
					 	 "GROUP BY to_char(created_time, 'ddMMyyyyHH24')";
			ResultSet rs = db.Select(sql, true, st);
			while(rs.next()){
				Calendar c = Calendar.getInstance();
			    c.setTime(rs.getDate("time"));
			    String key  = Long.toString(c.getTimeInMillis()/ (1000 * 60 * 60));				
			    int score = rs.getInt("score");
				map.put(key, score);
			}
						
			st.close();
			rs.close();
			db.close();
			
		} catch (SQLException e) {
			logger.error("SQLException", e);
		}

		return map;
	}
}
