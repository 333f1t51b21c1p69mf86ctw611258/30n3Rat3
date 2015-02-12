package eonerateui.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import eonerateui.db.pool.DBConfig;
import eonerateui.util.Item;
import eonerateui.util.RCTariff;

public class RCTariffDAO {
	private static DBConfig dbconfig = new DBConfig();
	static int SUCCESS = 0;
	static int ERROR = -1;
	static String schemaCommon = dbconfig.getDb_schema();

	public static ArrayList<Item> getListSubs_Status(Connection conn) {
		ArrayList<Item> mapitem = new ArrayList<Item>();
		PreparedStatement pstmt = null;
		try {
			String sql = "SELECT status_id,status_Name  from " + schemaCommon
					+ "SUBSCRIBER_STATUS";
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item(rs.getInt(1), rs.getString(2));
				mapitem.add(item);
			}
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapitem;
	}

	public static ArrayList<Item> getListRC_Tariff_Type(Connection conn) {
		ArrayList<Item> mapitem = new ArrayList<Item>();
		PreparedStatement pstmt = null;
		try {
			String sql = "SELECT rc_tariff_type_id,type_name  from "
					+ schemaCommon + "RC_TARIFF_TYPE";
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item(rs.getInt(1), rs.getString(2));
				mapitem.add(item);
			}
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapitem;
	}

	public static ArrayList<Item> getListProduct(Connection conn) {
		ArrayList<Item> mapitem = new ArrayList<Item>();
		PreparedStatement pstmt = null;
		try {
			String sql = "SELECT offer_id,offer_name  from " + schemaCommon
					+ "PRODUCT_OFFER";
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item(rs.getInt(1), rs.getString(2));
				mapitem.add(item);
			}
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapitem;
	}

	public static ArrayList<RCTariff> getListRCTariff(Connection conn) {

		ArrayList<RCTariff> searchResult = new ArrayList<RCTariff>();
		PreparedStatement pstmt = null;

		try {
			// String sql =
			// "SELECT a.number_of_days,b.offer_id,b.offer_name,a.rc_tariff_type_id,c.type_name,d.status_id,d.status_name,tariff_value,full_cycle, tariff_id ";
			// sql +="	from " + schemaCommon + "RC_TARIFF a  ";
			// sql +="	inner join " + schemaCommon + "PRODUCT_OFFER  b ";
			// sql +="	on  b.offer_id=a.product_offer_version_id ";
			// sql +="	inner join " + schemaCommon + "RC_TARIFF_TYPE c ";
			// sql +="	on C.RC_TARIFF_TYPE_ID =a.RC_TARIFF_TYPE_ID ";
			// sql +="	inner join " + schemaCommon + "SUBSCRIBER_STATUS d ";
			// sql +="	on d.status_id =a.status_id ";
			// sql +="	order by a.number_of_days ";

			String sql = "SELECT a.number_of_days,b.offer_id,b.offer_name,a.rc_tariff_type_id,c.type_name,d.status_id,d.status_name,tariff_value,full_cycle, tariff_id ";
			sql += "	from " + schemaCommon + "RC_TARIFF a  ";
			sql += "	inner join " + schemaCommon + "PRODUCT_OFFER  b ";
			sql += "	on  b.offer_id=a.offer_id ";
			sql += "	inner join " + schemaCommon + "RC_TARIFF_TYPE c ";
			sql += "	on C.RC_TARIFF_TYPE_ID =a.RC_TARIFF_TYPE_ID ";
			sql += "	inner join " + schemaCommon + "SUBSCRIBER_STATUS d ";
			sql += "	on d.status_id =a.status_id ";
			sql += "	order by a.number_of_days ";

			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {

				RCTariff rc = new RCTariff(rs.getInt(1), rs.getInt(2),
						rs.getString(3), rs.getInt(4), rs.getString(5),
						rs.getInt(6), rs.getString(7), rs.getInt(8),
						rs.getInt(9), rs.getInt(10));
				searchResult.add(rc);
			}
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchResult;
	}

	public static ArrayList<RCTariff> getListSearchRCTariff(Connection conn,
			Integer offerId, Integer typeId, Integer statusId) {

		ArrayList<RCTariff> searchResult = new ArrayList<RCTariff>();
		PreparedStatement pstmt = null;

		try {
			// String sql =
			// "SELECT a.number_of_days,b.offer_id,b.offer_name,a.rc_tariff_type_id,c.type_name,d.status_id,d.status_name,tariff_value,full_cycle, tariff_id ";
			// sql +="	from " + schemaCommon + "RC_TARIFF a  ";
			// sql +="	inner join " + schemaCommon + "PRODUCT_OFFER  b ";
			// sql +="	on  b.offer_id=a.PRODUCT_OFFER_VERSION_ID ";
			// sql +="	inner join " + schemaCommon + "RC_TARIFF_TYPE c ";
			// sql +="	on C.RC_TARIFF_TYPE_ID =a.RC_TARIFF_TYPE_ID ";
			// sql +="	inner join " + schemaCommon + "SUBSCRIBER_STATUS d ";
			// sql +="	on d.status_id =a.status_id ";

			String sql = "SELECT a.number_of_days,b.offer_id,b.offer_name,a.rc_tariff_type_id,c.type_name,d.status_id,d.status_name,tariff_value,full_cycle, tariff_id ";
			sql += "	from " + schemaCommon + "RC_TARIFF a  ";
			sql += "	inner join " + schemaCommon + "PRODUCT_OFFER  b ";
			sql += "	on  b.offer_id=a.offer_id ";
			sql += "	inner join " + schemaCommon + "RC_TARIFF_TYPE c ";
			sql += "	on C.RC_TARIFF_TYPE_ID =a.RC_TARIFF_TYPE_ID ";
			sql += "	inner join " + schemaCommon + "SUBSCRIBER_STATUS d ";
			sql += "	on d.status_id =a.status_id ";

			if (offerId != null && offerId != 0) {
				sql += " where b.offer_id=" + offerId;
			}
			if (typeId != null && typeId != 0) {
				sql += " and c.rc_tariff_type_id=" + typeId;
			}
			if (statusId != null && statusId != 0) {
				sql += " and  d.status_id=" + statusId;
			}
			sql += "	order by a.number_of_days ";
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {

				RCTariff rc = new RCTariff(rs.getInt(1), rs.getInt(2),
						rs.getString(3), rs.getInt(4), rs.getString(5),
						rs.getInt(6), rs.getString(7), rs.getInt(8),
						rs.getInt(9), rs.getInt(10));
				searchResult.add(rc);
			}
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchResult;
	}

	public static RCTariff get(Connection conn, Integer id) {
		PreparedStatement pstmt = null;
		RCTariff rc = null;
		try {
//			String sql = "SELECT a.number_of_days,b.offer_id,b.offer_name,a.rc_tariff_type_id,c.type_name,d.status_id,d.status_name,tariff_value,full_cycle, tariff_id ";
//			sql += "	from " + schemaCommon + "RC_TARIFF a  ";
//			sql += "	inner join " + schemaCommon + "PRODUCT_OFFER  b ";
//			sql += "	on  b.offer_id=a.product_offer_version_id ";
//			sql += "	inner join " + schemaCommon + "RC_TARIFF_TYPE c ";
//			sql += "	on C.RC_TARIFF_TYPE_ID =a.RC_TARIFF_TYPE_ID ";
//			sql += "	inner join " + schemaCommon + "SUBSCRIBER_STATUS d ";
//			sql += "	on d.status_id =a.status_id ";
//			sql += " where a.tariff_id=" + id;
			
			String sql = "SELECT a.number_of_days,b.offer_id,b.offer_name,a.rc_tariff_type_id,c.type_name,d.status_id,d.status_name,tariff_value,full_cycle, tariff_id ";
			sql += "	from " + schemaCommon + "RC_TARIFF a  ";
			sql += "	inner join " + schemaCommon + "PRODUCT_OFFER  b ";
			sql += "	on  b.offer_id=a.offer_id ";
			sql += "	inner join " + schemaCommon + "RC_TARIFF_TYPE c ";
			sql += "	on C.RC_TARIFF_TYPE_ID =a.RC_TARIFF_TYPE_ID ";
			sql += "	inner join " + schemaCommon + "SUBSCRIBER_STATUS d ";
			sql += "	on d.status_id =a.status_id ";
			sql += " where a.tariff_id=" + id;
			
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				rc = new RCTariff(rs.getInt(1), rs.getInt(2), rs.getString(3),
						rs.getInt(4), rs.getString(5), rs.getInt(6),
						rs.getString(7), rs.getInt(8), rs.getInt(9),
						rs.getInt(10));
			}
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rc;
	}

	public static int createRCTariff(RCTariff rcTariff, Connection conn) {

		PreparedStatement stmt = null;
		try {
//			String sql = "INSERT INTO "
//					+ schemaCommon
//					+ "RC_TARIFF(number_of_days,product_offer_version_id,rc_tariff_type_id,status_id,tariff_value,full_cycle) ";
//			sql += "VALUES('" + rcTariff.getDay();
//			sql += "','" + rcTariff.getProductId();
//			sql += "','" + rcTariff.getTypeId();
//			sql += "','" + rcTariff.getStatusId();
//			sql += "','" + rcTariff.getValue();
//			sql += "','" + rcTariff.getFullCycle() + "')";
			
			String sql = "INSERT INTO "
					+ schemaCommon
					+ "RC_TARIFF(number_of_days,offer_id,rc_tariff_type_id,status_id,tariff_value,full_cycle) ";
			sql += "VALUES('" + rcTariff.getDay();
			sql += "','" + rcTariff.getProductId();
			sql += "','" + rcTariff.getTypeId();
			sql += "','" + rcTariff.getStatusId();
			sql += "','" + rcTariff.getValue();
			sql += "','" + rcTariff.getFullCycle() + "')";
			
			stmt = conn.prepareStatement(sql);
			stmt.execute(sql);
			conn.commit();
			conn.close();
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	public static int QuickcreateRCTariff(RCTariff rcTariff, Connection conn) {

		PreparedStatement stmt = null;
		try {
//			String sql = "INSERT INTO "
//					+ schemaCommon
//					+ "RC_TARIFF(number_of_days,product_offer_version_id,rc_tariff_type_id,status_id,tariff_value,full_cycle) ";
//			sql += "VALUES('" + rcTariff.getDay();
//			sql += "','" + rcTariff.getProductId();
//			sql += "','" + rcTariff.getTypeId();
//			sql += "','" + rcTariff.getStatusId();
//			sql += "','" + rcTariff.getValue();
//			sql += "','" + rcTariff.getFullCycle() + "')";
			
			String sql = "INSERT INTO "
					+ schemaCommon
					+ "RC_TARIFF(number_of_days,offer_id,rc_tariff_type_id,status_id,tariff_value,full_cycle) ";
			sql += "VALUES('" + rcTariff.getDay();
			sql += "','" + rcTariff.getProductId();
			sql += "','" + rcTariff.getTypeId();
			sql += "','" + rcTariff.getStatusId();
			sql += "','" + rcTariff.getValue();
			sql += "','" + rcTariff.getFullCycle() + "')";
			
			stmt = conn.prepareStatement(sql);
			stmt.execute(sql);
			conn.commit();

		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}
	
	public static Boolean checkExistTariff(int offer_id,int statusId, 
										   int day, Connection conn) {

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			
			String query = "SELECT count(1) FROM " + schemaCommon
					+ "RC_TARIFF where offer_id = '" + offer_id	
					+ "'  and number_of_days='" + day  
					+ "'  and status_id='" + statusId+"'";
			
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery(query);
			rs.next();
			result = rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		}

		if (result > 0)
			return true;
		else
			return false;
	}
	
	
	public static Boolean checkExistCode(int day, int offer_id, int typeId,
			int statusId, Connection conn) {

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
//			String query = "SELECT count(1) FROM " + schemaCommon
//					+ "RC_TARIFF where product_offer_version_id = '" + offer_id
//					+ "' and rc_tariff_type_id='" + typeId
//					+ "' and status_id='" + statusId
//					+ "'  and number_of_days='" + day + "'";
			
			String query = "SELECT count(1) FROM " + schemaCommon
					+ "RC_TARIFF where offer_id = '" + offer_id
					+ "' and rc_tariff_type_id='" + typeId
					+ "' and status_id='" + statusId
					+ "'  and number_of_days='" + day + "'";
			
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery(query);
			rs.next();
			result = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		}

		if (result > 0)
			return true;
		else
			return false;
	}

	public static int updateRCTariff(RCTariff rcTariff, Connection conn) {
		PreparedStatement stmt = null;
		try {
//			String sql = "UPDATE " + schemaCommon + "RC_TARIFF ";
//			sql += " SET tariff_value=" + rcTariff.getValue() + ",full_cycle="
//					+ rcTariff.getFullCycle() + "";
//			sql += " WHERE TARIFF_ID = '" + rcTariff.getId() + "'";
			
			String sql = "UPDATE " + schemaCommon + "RC_TARIFF ";
			sql += " SET tariff_value=" + rcTariff.getValue() + ",full_cycle="
					+ rcTariff.getFullCycle() + "";
			sql += " WHERE TARIFF_ID = '" + rcTariff.getId() + "'";
			
			stmt = conn.prepareStatement(sql);
			stmt.execute(sql);
			conn.commit();
			conn.close();
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
			return ERROR;
		}
		return SUCCESS;
	}

	public static int deleteRCTariff(int Id, Connection conn) {

		PreparedStatement stmt = null;
		try {
			String sql = "DELETE FROM " + schemaCommon + "RC_TARIFF ";
			sql += " WHERE TARIFF_ID = '" + Id + "'";
			stmt = conn.prepareStatement(sql);
			stmt.execute(sql);
			conn.commit();
			conn.close();
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
			return ERROR;
		}

		return SUCCESS;
	}

	public static int deleteAll(Integer offerId, Integer typeId,
			Integer statusId, Connection conn) {

		PreparedStatement stmt = null;
		try {
//			String sql = "DELETE FROM " + schemaCommon + "RC_TARIFF ";
//			sql += " WHERE PRODUCT_OFFER_VERSION_ID = '" + offerId + "'";
			
			String sql = "DELETE FROM " + schemaCommon + "RC_TARIFF ";
			sql += " WHERE offer_id = '" + offerId + "'";
			
			if (typeId != null && typeId != 0) {
				sql += " and rc_tariff_type_id=" + typeId;
			}
			if (statusId != null && statusId != 0) {
				sql += " and  status_id=" + statusId;
			}

			stmt = conn.prepareStatement(sql);
			stmt.execute(sql);
			conn.commit();
			conn.close();
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
			return ERROR;
		}

		return SUCCESS;
	}
}
