package eonerateui.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import org.apache.log4j.Logger;

import eonerateui.db.pool.DBConfig;
import eonerateui.db.pool.DBPool;
import eonerateui.entity.search.output.ProductSearchOutput;

public class ProductDAO {
	private static Logger logger=Logger.getLogger("ProductDAO");
	public static ArrayList<ProductSearchOutput> searchProduct(String subscriptionId, Date fromDate, Date toDate) {
		ArrayList<ProductSearchOutput> searchResult = new ArrayList<ProductSearchOutput>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuilder query = new StringBuilder("");
		try{
			conn = getConnection();
			String schema = (new DBConfig()).getDb_schema();
			/*
			 * setting querry
			 */
			query.append("SELECT b.subscriber_no, c.product_offer_version_name, c.from_date, c.to_date ");
			query.append("FROM " + schema + "subs_offer_map a  LEFT JOIN " + schema + "subscriber  b ON a.subscriber_id = b.subscriber_id ");
			query.append("LEFT JOIN " + schema + "product_offer_version c ON a.product_offer_version_id = c.product_offer_version_id ");
			query.append("WHERE b.subscriber_no LIKE ? ");
			if(fromDate != null){query.append("AND c.from_date >= ? ");}
			if(toDate != null){query.append("AND c.to_date <= ? ");}
			
			/*
			 * setting prepare statement
			 */
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, "%" + subscriptionId + "%");
			if(fromDate != null){pstmt.setLong(2, fromDate.getTime()/1000);}
			if(toDate != null){
				if(fromDate!=null){
					pstmt.setLong(3, toDate.getTime()/1000);
				}else{
					pstmt.setLong(2, toDate.getTime()/1000);
				}
			}
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				  String subscriber = rs.getString("subscriber_no");
				  
				  String startDate = (rs.getDate("from_date") != null) ? rs.getDate("from_date").toString() : "";
				  String endDate = (rs.getDate("to_date") != null) ? rs.getDate("to_date").toString() : "";
				  String productOfferVersionName = rs.getString("product_offer_version_name");
				  ProductSearchOutput output = new ProductSearchOutput(subscriber, startDate, endDate, productOfferVersionName);
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
