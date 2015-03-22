package eonerateui.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import eonerateui.db.pool.DBConfig;
import eonerateui.db.pool.DBPool;
import eonerateui.entity.search.output.DiscountSearchOutput;

public class DiscountDAO {
	private static Logger logger=Logger.getLogger("DiscountDAO");
	public static ArrayList<DiscountSearchOutput> searchDiscount(String discountIn, String zone) {
		ArrayList<DiscountSearchOutput> searchResult = new ArrayList<DiscountSearchOutput>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuilder query = new StringBuilder("");
		try{
			conn = getConnection();
			/*
			 * setting querry
			 */
			query.append("SELECT discount_in, zone_in, discount_out ");
			query.append("FROM " + (new DBConfig()).getDb_schema() + "discount_map ");	
			query.append("WHERE discount_out LIKE ? ");
			query.append("AND zone_in LIKE ? ");
			/*
			 * setting prepare statement
			 */
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, "%" + discountIn + "%");
			pstmt.setString(2, "%" + zone + "%");
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				  DiscountSearchOutput output = new DiscountSearchOutput(rs.getString(1), rs.getString(2), rs.getString(3));
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
