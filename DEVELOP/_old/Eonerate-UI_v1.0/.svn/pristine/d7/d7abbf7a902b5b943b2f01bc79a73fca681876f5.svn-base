package eonerateui.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import eonerateui.db.pool.DBconnect;
import eonerateui.util.CodeConstants;
import eonerateui.util.MessageConstants;

public class SqlLoaderCsvFilesDAO {
	private static Logger logger=Logger.getLogger("SqlLoaderCsvFilesDAO");
	public static ArrayList<SqlLoaderCsvFiles> getAllCsvFile(){
		ArrayList<SqlLoaderCsvFiles> searchResult = new ArrayList<SqlLoaderCsvFiles>();
		try{
			DBconnect db = new DBconnect();
			Statement st = db.createStatement();
			String sql = "SELECT file_name, status, to_char(created_time,'dd/MM/yyyy HH24:MI:SS') created_time, to_char(last_changed_time,'dd/MM/yyyy HH24:MI:SS') last_changed_time, bad_file " +
						 "FROM " + db.getDbconfig().getDb_data_schema() + "rated_csv_file " +
						 "WHERE (status = '" + CodeConstants.CSV_STATUS_CODE.INITIALIZE + "' or status = '" + CodeConstants.CSV_STATUS_CODE.LOADING + "')" + 
						 "	 OR (status = '" + CodeConstants.CSV_STATUS_CODE.FINISHED + "' AND bad_file = '" + CodeConstants.CSV_BADFILE_CODE.HAS_BAD + "')" +
						 "	 OR (status = '" + CodeConstants.CSV_STATUS_CODE.FINISHED + "' AND last_changed_time LIKE sysdate)" + 
						 "ORDER BY created_time";
			
			//chỉ lấy ra các cvs file la INITIALIZE (có thể lấy LOADING để xem máy nào đang load)
			ResultSet rs = db.Select(sql, true, st);
			while(rs.next()){
				  String fileName = rs.getString("file_name");
				  String status = getStatusString(rs.getString("status"));
				  String createdTime = rs.getString("created_time");
				  String lastChangedTime = rs.getString("last_changed_time");
				  String badFile = getHasBadFile(rs.getString("bad_file"));
				  
				  SqlLoaderCsvFiles sqlLoaderCsvFiles = new SqlLoaderCsvFiles(fileName, status, createdTime, lastChangedTime, badFile);
				  searchResult.add(sqlLoaderCsvFiles);
			}
			st.close();
			rs.close();
			db.close();
			
		}catch(Exception e){
			logger.error("Exception", e);
		}
		
		return searchResult;
	}
		
	private static String getHasBadFile(String badFile){
		String returnString="";
		
		if(StringUtils.isNotEmpty(badFile)){
			int iBadFile = Integer.parseInt(badFile);
			if (iBadFile == CodeConstants.CSV_BADFILE_CODE.NEW_FILE) {
				returnString = MessageConstants.BAD_FILE.NEW_FILE;
			} 
			else if (iBadFile == CodeConstants.CSV_BADFILE_CODE.HAS_BAD) {
				returnString = MessageConstants.BAD_FILE.HAS_BAD;
			}
			else if (iBadFile == CodeConstants.CSV_BADFILE_CODE.SUCCESS) {
				returnString = MessageConstants.BAD_FILE.SUCCESS;
			}
		}

		return returnString;
	}
	
	private static String getStatusString(String statusCode){
		String returnString="";

		if(StringUtils.isNotEmpty(statusCode)){
			int iBadFile = Integer.parseInt(statusCode);
			if (iBadFile == CodeConstants.CSV_STATUS_CODE.INITIALIZE) {
				returnString = MessageConstants.CSV_STATUS.INITIALIZE;
			} 
			else if (iBadFile == CodeConstants.CSV_STATUS_CODE.LOADING) {
				returnString = MessageConstants.CSV_STATUS.LOADING;
			}
			else if (iBadFile == CodeConstants.CSV_STATUS_CODE.FINISHED) {
				returnString = MessageConstants.CSV_STATUS.FINISHED;
			}
		}
		
		return returnString;
	}
	
	public static void updateCSVLoadStatus(String fileName, int loadStatus, String badFile, DBconnect db) throws SQLException {
		db.Update("UPDATE " + db.getDbconfig().getDb_data_schema() + "rated_csv_file SET status = '" + Integer.toString(loadStatus) + "', last_changed_time = sysdate, bad_file ='" + badFile + "' WHERE file_name='" + fileName + "'");
		db.commit();
	}

	public static void moveData2RatedCDR(String sourceTable) {
		try {
			DBconnect db = new DBconnect();
			db.Update("INSERT INTO " + db.getDbconfig().getDb_data_schema() + "rated_cdr SELECT * FROM " + db.getDbconfig().getDb_data_schema() + sourceTable);
			db.commit();
			db.close();
		} catch (SQLException e) {
			logger.error("Exception", e);
		}
	}
	
	public static void aggregateCDR(String viewName) {
		try {
			DBconnect db = new DBconnect();
			Connection conn = db.getConn();
			PreparedStatement stmt = null;
			
			StringBuilder updateQuery = new StringBuilder();
			updateQuery.append(" UPDATE " + db.getDbconfig().getDb_data_schema() + "aggregated_cdr x ");
			updateQuery.append(" SET (total_cdr, total_usage, service_fee, offer_cost, offer_free_block, internal_cost, internal_free_block) ");
			updateQuery.append("= 	(SELECT /*+ PARALLEL(, 4) */ ");
			updateQuery.append("			x.total_cdr + total_cdr, ");
			updateQuery.append("			x.total_usage + x.total_usage,");
			updateQuery.append("			x.service_fee + service_fee,");
			updateQuery.append("			x.offer_cost + offer_cost,");
			updateQuery.append("			x.offer_free_block + offer_free_block,");
			updateQuery.append("			x.internal_cost + internal_cost,");
			updateQuery.append("			x.internal_free_block + internal_free_block ");
			updateQuery.append("		FROM " + db.getDbconfig().getDb_data_schema() + viewName ); 
			updateQuery.append("		WHERE x.a_number = a_number AND x.bill_month=bill_month AND x.cdr_type= cdr_type AND x.payment_item_id = payment_item_id)");
			updateQuery.append(" WHERE EXISTS");
			updateQuery.append(" (SELECT 1 FROM " + db.getDbconfig().getDb_data_schema() + "aggregated_cdr x WHERE  x.a_number = a_number AND x.bill_month=bill_month AND x.cdr_type= cdr_type AND x.payment_item_id = payment_item_id) ");
			
			StringBuilder insertQuery = new StringBuilder();
			insertQuery.append(" INSERT INTO " + db.getDbconfig().getDb_data_schema() + "aggregated_cdr(a_number, cdr_type, total_cdr, bill_month, total_usage, service_fee, offer_cost, offer_free_block, internal_cost, internal_free_block, payment_item_id)");
			insertQuery.append(" SELECT /*+ PARALLEL(, 4) */ a_number, cdr_type, total_cdr, bill_month, total_usage, service_fee, offer_cost, offer_free_block, internal_cost, internal_free_block, payment_item_id");
			insertQuery.append(" FROM " + db.getDbconfig().getDb_data_schema() + viewName);
			insertQuery.append(" WHERE NOT EXISTS");
			insertQuery.append(" (SELECT 1 FROM " + db.getDbconfig().getDb_data_schema() + "aggregated_cdr x WHERE  x.a_number = a_number AND x.bill_month=bill_month AND x.cdr_type= cdr_type AND x.payment_item_id = payment_item_id) ");
			
			logger.info("[Start] updateQuery");
			stmt = conn.prepareStatement(updateQuery.toString());
			stmt.execute(updateQuery.toString());
			logger.info("[End] UpdateQuery");
			
			logger.info("ViewName = " + viewName);
			logger.info("[Start] insertingQuery");
			logger.info(insertQuery.toString());
			logger.info(updateQuery.toString());
			stmt = conn.prepareStatement(insertQuery.toString());
			stmt.execute(insertQuery.toString());
			logger.info("[End] insertQuery");
			
			db.commit();
			db.close();
		} catch (SQLException e) {
			logger.error("Exception", e);
		}
	}
	
	
}

