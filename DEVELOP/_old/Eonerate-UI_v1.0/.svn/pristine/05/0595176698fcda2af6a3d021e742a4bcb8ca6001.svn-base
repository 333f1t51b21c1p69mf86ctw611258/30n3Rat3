package eonerateui.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import eonerateui.db.pool.DBConfig;
import eonerateui.db.pool.DBPool;
import eonerateui.entity.search.output.SubscriberSearchOutput;

public class SubscriberDAO {
	private static Logger logger=Logger.getLogger("SubscriberDAO");
	public static ArrayList<SubscriberSearchOutput> searchSubscriber(String subscriptionId, String fromDate, String toDate) {
		ArrayList<SubscriberSearchOutput> searchResult = new ArrayList<SubscriberSearchOutput>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuilder query = new StringBuilder("");
		try{
			conn = getConnection();
			String schema = (new DBConfig()).getDb_schema();
			
			/*
			 * setting querry
			 */
			query.append("SELECT a.subscriber_no , b.from_date, b.to_date, b.subscriber_version_id ");
			query.append("FROM " + schema + "subscriber a INNER JOIN " + schema + "subscriber_version b ");	
			query.append("ON a.subscriber_id = b.subscriber_id ");
			query.append("AND a.subscriber_no LIKE ? ");
			query.append("AND rownum < 5000");
			
			if(StringUtils.isNotEmpty(fromDate)){query.append("AND b.from_date >= to_date( ? ,'MM/DD/YYYY')");}
			if(StringUtils.isNotEmpty(toDate)){query.append("AND b.to_date <= to_date( ? ,'MM/DD/YYYY')");}
			
			/*
			 * setting prepare statement
			 */
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, "%" + subscriptionId + "%");
			if(StringUtils.isNotEmpty(fromDate)){pstmt.setString(2, fromDate.toString());}
			if(StringUtils.isNotEmpty(toDate)){
				if(fromDate!=null){
					pstmt.setString(3, toDate.toString());
				}else{
					pstmt.setString(2, toDate.toString());
				}
			}
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				  String subscriber = rs.getString("subscriber_no");
				  String startDate = rs.getDate("from_date").toString();
				  String endDate = rs.getDate("to_date").toString();
				  Integer subscriberVersionId = rs.getInt("subscriber_version_id");
				  SubscriberSearchOutput output = new SubscriberSearchOutput(subscriber, startDate, endDate, subscriberVersionId.toString());
				  searchResult.add(output);
			}
			pstmt.close();
		}catch(Exception e){
			logger.error("Exception", e);
		}
		
		releaseConnection(conn, pstmt);
		return searchResult;
	}

	public static Connection getConnection() throws SQLException {
		return DBPool.getConnection();
	}
	public static void releaseConnection(Connection conn, PreparedStatement preStmt) {
		DBPool.releaseConnection(conn, preStmt);
	}

}
