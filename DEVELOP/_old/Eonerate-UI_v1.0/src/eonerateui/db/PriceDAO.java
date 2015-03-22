package eonerateui.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import eonerateui.db.pool.DBConfig;
import eonerateui.db.pool.DBPool;
import eonerateui.entity.search.output.PricesSearchOutput;

public class PriceDAO {
	private static Logger logger=Logger.getLogger("PriceDAO");
	public static ArrayList<PricesSearchOutput> listAllPricesModels() {
		ArrayList<PricesSearchOutput> searchResult = new ArrayList<PricesSearchOutput>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuilder query = new StringBuilder("");
		try{
			conn = getConnection();
			query.append("SELECT * FROM " + (new DBConfig()).getDb_schema() + "price_model ORDER BY price_model, step ");
			pstmt = conn.prepareStatement(query.toString());
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				  String priceModel = rs.getString(1);
				  String step = rs.getString(2);
				  String tierFrom = rs.getString(3);
				  String tierTo = rs.getString(4);
				  String beat = rs.getString(5);
				  String factor = rs.getString(6);
				  String chargeBase = rs.getString(7);
				  
				  PricesSearchOutput output = new PricesSearchOutput(priceModel, step, tierFrom, tierTo, beat, factor, chargeBase);
				  searchResult.add(output);
			}
			pstmt.close();
		}catch(Exception e){
			logger.error("Exception", e);
		}
		
		releaseConnection(conn, pstmt);
		return searchResult;
	}

	public static ArrayList<PricesSearchOutput> searchPrice(String productId) {
		ArrayList<PricesSearchOutput> searchResult = new ArrayList<PricesSearchOutput>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuilder query = new StringBuilder("");
		try{
			conn = getConnection();
			query.append("SELECT * FROM " + (new DBConfig()).getDb_schema() + "price_model ");
			query.append("WHERE price_model LIKE ? ");
			query.append("ORDER BY price_model, step");
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, "%" + productId + "%");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				  String priceModel = rs.getString(1);
				  String step = rs.getString(2);
				  String tierFrom = rs.getString(3);
				  String tierTo = rs.getString(4);
				  String beat = rs.getString(5);
				  String factor = rs.getString(6);
				  String chargeBase = rs.getString(7);
				  PricesSearchOutput output = new PricesSearchOutput(priceModel, step, tierFrom, tierTo, beat, factor, chargeBase);
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
