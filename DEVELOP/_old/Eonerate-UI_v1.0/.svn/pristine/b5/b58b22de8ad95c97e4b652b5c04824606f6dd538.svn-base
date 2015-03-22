package eonerateui.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import eonerateui.util.RC_Tariff;
import eonerateui.controller.rc_rating.RC_ThreadControl;
import eonerateui.controller.xml.xmlParser;
import eonerateui.db.pool.DBconnect;
import eonerateui.gui.menu.rating.RC_Rating;
import eonerateui.util.MessageConstants;

public class RcRatingDAO {
	
	public static void updateLog(DBconnect db, boolean bulkLoad, String schemaData) {
		try {
			RC_Rating.setStatus(MessageConstants.RC_RATING.UPDATING_LOG);

			String sInsertType;
			if (bulkLoad)
				sInsertType = "0";
			else
				sInsertType = "1";
			
			db.Update("INSERT INTO " + schemaData + "rc_log(rate_time, insert_type) VALUES(sysdate,'" + sInsertType + "')");
			if (!bulkLoad) db.commit();
			
			RC_Rating.setStatus(MessageConstants.RC_RATING.UPDATED_LOG);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static String getNow(DBconnect db) {
		//Database connecting to get current time of DB server for calculating the delay time of task schedule
		String sNow = null;
		try {
			if (db == null) db= new DBconnect();
			Statement stTimer;
			stTimer = db.createStatement();
			ResultSet rsTimer = db.Select("SELECT to_char(sysdate, 'HH24:MI:SS') now FROM dual", true, stTimer);
		
			if (rsTimer.next()) {
				sNow = rsTimer.getString("now");
			}
			
			rsTimer.close();
			stTimer.close();
		
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return sNow;
	}

	public static int getTotalSubs(DBconnect db, String beginDate, String endDate, boolean fullCycle, boolean allSubs, String schema) {
		int maxSubs = 0;
		try {
			RC_Rating.setStatus(MessageConstants.RC_RATING.COUNTING_SUBSCRIBERS);
	
			String sEndDate;
			if (fullCycle) 
				sEndDate = endDate;
			else 
				sEndDate = "decode(sign(" + endDate + " - sysdate), 1, sysdate, " + endDate + ")";
	
			String sWhereAllSub = "";
			if (!allSubs)
				sWhereAllSub = 	"AND EXISTS (SELECT 1 FROM " + schema + "subs_offer_map" +
								"			 WHERE subscriber_id = a.subscriber_id" + 
			                 	"		       AND (from_date BETWEEN " + beginDate + " AND " + sEndDate + 
			                 	"			   OR  to_date BETWEEN " + beginDate + " AND " + sEndDate + "))";
	  
	
			String sql =  "SELECT count(1) recordCount FROM " + schema + "subscriber a " +
						  "WHERE EXISTS (SELECT max(start_date) FROM " + schema + "subs_status_map" +
				          "    			 WHERE subscriber_id = a.subscriber_id" + 
				          "				   AND start_date < " + sEndDate + ") " + sWhereAllSub;
			
			Statement st;
			st = db.createStatement();

			ResultSet rsCount = db.Select(sql, true, st);
			rsCount.beforeFirst();
			rsCount.next();

			maxSubs = rsCount.getInt("recordCount");
			rsCount.close();
			st.close();
			
			if (maxSubs==0) {
				RC_Rating.setStatus(MessageConstants.RC_RATING.NO_SUBSCRIBER_FOUND);
				RC_Rating.setIndeterminate(false);
			}
			else {
				RC_Rating.setStatus(String.format(MessageConstants.RC_RATING.TOTAL_SUBSCRIBER, maxSubs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return maxSubs;
	}	
	
	public static HashMap<String, RC_Tariff> loadProductRC(DBconnect db, String beginDate, String endDate, int packageSelected, String schema, String vas_service) {
		HashMap<String, RC_Tariff> mapTariff = null;
		try {
			RC_Rating.setStatus(MessageConstants.RC_RATING.LOAD_TARIFF_TO_MEMORY);

			String s="";
			
//		    switch (packageSelected) {
//	       		case 0:
////	       			s = "SELECT a.product_offer_version_id||'_'||b.status_id||'_'||b.number_of_days key, b.tariff_value, b.RC_tariff_type_id, b.full_cycle " +
////	       				"FROM " + schema + "product_offer_version a, " + schema + "rc_tariff b " +
////	       				 "WHERE a.product_offer_version_id = b.product_offer_version_id" +
////	       				 "  AND a.from_date <=" + endDate +
////	       		    	 "  AND (a.to_date is null OR a.to_date>="+ beginDate + ")";
//	       			
//	       			s = "SELECT a.offer_id||'_'||b.status_id||'_'||b.number_of_days key, b.tariff_value, b.RC_tariff_type_id, b.full_cycle " +
//		       				"FROM " + schema + "product_offer a, " + schema + "rc_tariff b " +
//		       				 "WHERE a.offer_id = b.offer_id" +
//		       				 "  AND a.sales_effective_time <=" + endDate +
//		       		    	 "  AND (a.sales_expiration_time is null OR a.sales_expiration_time >= "+ beginDate + ")";
//	       		break;
//	
//	       		case 1:
////	       			s = "SELECT a.product_offer_version_id||'_'||b.status_id||'_'||b.number_of_days key, b.tariff_value, b.RC_tariff_type_id, b.full_cycle " +
////	       				"FROM " + schema + "product_offer_version a, " + schema + "rc_tariff b, " + schema + "po_service_map c " +
////	       				"WHERE a.product_offer_version_id = b.product_offer_version_id" +
////	       				"  AND a.product_offer_id = c.product_offer_id" +
////	       				"  AND c.service_id in (SELECT service_id FROM service WHERE vas<>" + vas_service + ")" +
////		  				"  AND a.from_date <=" + endDate +
////		   		    	"  AND (a.to_date is null OR a.to_date>="+ beginDate + ")";
//	       			
//	       			s = "SELECT a.offer_id||'_'||b.status_id||'_'||b.number_of_days key, b.tariff_value, b.RC_tariff_type_id, b.full_cycle " +
//		       				"FROM " + schema + "product_offer a, " + schema + "rc_tariff b, " + schema + "po_service_map c " +
//		       				"WHERE a.offer_id = b.offer_id" +
//		       				"  AND a.offer_id = c.offer_id" +
//		       				"  AND c.service_id in (SELECT service_id FROM service WHERE vas<>" + vas_service + ")" +
//			  				"  AND a.sales_effective_time <=" + endDate +
//			   		    	"  AND (a.sales_expiration_time is null OR a.sales_expiration_time>="+ beginDate + ")";
//	        		break;
//	       		   
//	      		case 2:
////	       			s = "SELECT a.product_offer_version_id||'_'||b.status_id||'_'||b.number_of_days key, b.tariff_value, b.RC_tariff_type_id, b.full_cycle " +
////	           			"FROM " + schema + "product_offer_version a, " + schema + "rc_tariff b, " + schema + "po_service_map c " +
////	           			"WHERE a.product_offer_version_id = b.product_offer_version_id" +
////	           			"  AND a.product_offer_id = c.product_offer_id" +
////	           			"  AND c.service_id in (SELECT service_id FROM service WHERE vas=" + vas_service + ")" +
////	       				"  AND a.from_date <=" + endDate +
////	       				"  AND (a.to_date is null OR a.to_date>="+ beginDate + ")";
//	       			
//	       			s = "SELECT a.offer_id||'_'||b.status_id||'_'||b.number_of_days key, b.tariff_value, b.RC_tariff_type_id, b.full_cycle " +
//		           			"FROM " + schema + "product_offer a, " + schema + "rc_tariff b, " + schema + "po_service_map c " +
//		           			"WHERE a.offer_id = b.offer_id" +
//		           			"  AND a.offer_id = c.offer_id" +
//		           			"  AND c.service_id in (SELECT service_id FROM service WHERE vas=" + vas_service + ")" +
//		       				"  AND a.sales_effective_time <=" + endDate +
//		       				"  AND (a.sales_expiration_time is null OR a.sales_expiration_time>="+ beginDate + ")";
//	         		break;
//		    }
		    
		    s = "SELECT a.offer_id||'_'||b.status_id||'_'||b.number_of_days key, b.tariff_value, b.RC_tariff_type_id, b.full_cycle " +
       				"FROM " + schema + "product_offer a, " + schema + "rc_tariff b " +
       				 "WHERE a.offer_id = b.offer_id" +
       				 "  AND a.sales_effective_time <=" + endDate +
       		    	 "  AND (a.sales_expiration_time is null OR a.sales_expiration_time >= "+ beginDate + ")";
		    
			Statement st;
			st = db.createStatement();
	    	ResultSet rs = db.Select(s, true, st);
	    	
	    	mapTariff = new HashMap<String, RC_Tariff>();
	    	RC_Tariff tariff;
			while (rs.next()) {
				tariff = new RC_Tariff();
				
				tariff.setRCTariffTypeID(rs.getInt("RC_tariff_type_id"));
				tariff.setTariffValue(rs.getDouble("tariff_value"));
				tariff.setFullCycle(rs.getString("full_cycle"));
				 
				mapTariff.put(rs.getString("key"), tariff);
			 }
	
			 st.close();
			 rs.close();

			RC_Rating.setStatus(MessageConstants.RC_RATING.LOADED_TARIFF);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return mapTariff;
	}
	
	public static void deleteOldRC(final RC_ThreadControl threadCtl, final DBconnect dbDtl, final DBconnect dbAgg, final String date,  final String beginDate, final String endDate, final int packageSelected, final String schema, final String schemaData, final String vas_service, final boolean allSubs, final boolean fullCycle) {
		String wherePO = "";

//	    switch (packageSelected) {
//   		case 1:
////   			wherePO = " AND EXISTS (SELECT 1 FROM " + schema + "product_offer_version" +
////   					  "				WHERE x.product_offer_version_id = product_offer_version_id" +
////   					  "				  AND product_offer_id IN (SELECT map.product_offer_id FROM " + schema + "po_service_map map, " + schema + "service sv" +
////   					  "										   WHERE map.service_id = sv.service_id AND sv.vas<>" + vas_service + "))";
//   			
//   			wherePO = " AND EXISTS (SELECT 1 FROM " + schema + "product_offer" +
// 					  "				WHERE x.offer_id = offer_id" +
// 					  "				  AND offer_id IN (SELECT map.offer_id FROM " + schema + "po_service_map map, " + schema + "service sv" +
// 					  "										   WHERE map.service_id = sv.service_id AND sv.vas<>" + vas_service + "))";
//   			break;
//   		   
//  		case 2:
////   			wherePO = " AND EXISTS (SELECT 1 FROM " + schema + "product_offer_version" +
//// 					  "				WHERE x.product_offer_version_id = product_offer_version_id" +
//// 					  "				  AND product_offer_id IN (SELECT map.product_offer_id FROM " + schema + "po_service_map map, " + schema + "service sv" +
//// 					  "										   WHERE map.service_id = sv.service_id AND sv.vas=" + vas_service + "))";
//   			
//   			wherePO = " AND EXISTS (SELECT 1 FROM " + schema + "product_offer" +
//					  "				WHERE x.offer_id = offer_id" +
//					  "				  AND offer_id IN (SELECT map.offer_id FROM " + schema + "po_service_map map, " + schema + "service sv" +
//					  "										   WHERE map.service_id = sv.service_id AND sv.vas=" + vas_service + "))";
//   			break;
//	    }
//		
		String whereAllSubs = "";
		if (!allSubs) {
			String sEndDate;
			if (fullCycle) 
				sEndDate = endDate;
			else 
				sEndDate = "decode(sign(" + endDate + " - sysdate), 1, sysdate, " + endDate + ")";

			
			whereAllSubs = " AND EXISTS (SELECT 1 FROM " + schema + "subs_offer_map" +              
		            	   "			 WHERE x.subscriber_id = subscriber_id" +            
		            	   "				AND (from_date BETWEEN " + beginDate + " AND " + sEndDate +
		            	   "				OR to_date BETWEEN " + beginDate + " AND " + sEndDate + "))";
		}

		String sqlDetail = "DELETE " + schemaData + "rated_rc x WHERE bill_month=to_date('" + date + "','ddMMyyyy')" + wherePO + whereAllSubs;
		String sqlAggreg = "DELETE " + schemaData + "aggregated_rc x WHERE bill_month=to_date('" + date + "','ddMMyyyy')" + wherePO + whereAllSubs;
		
		
		//delete chi tiet, bang tong hop cuoc RC
		deleteDetail(threadCtl, dbDtl, sqlDetail);
		deleteAggregated(threadCtl, dbAgg, sqlAggreg);
	}


	private static void deleteDetail(final RC_ThreadControl threadCtl, final DBconnect db, final String sql) {
		ExecutorService threadPool = Executors.newSingleThreadExecutor();
		threadPool.submit(new Runnable() {
			public void run() {		
				try {
					threadCtl.setDeleteDetailDone(false);
					
					RC_Rating.setStatus(MessageConstants.RC_RATING.DELETING_OLD_RC);
					db.Update(sql);
					RC_Rating.setStatus(MessageConstants.RC_RATING.DELETED_OLD_RC);

					threadCtl.setDeleteDetailDone(true);
					
				} catch (SQLException e) {
					threadCtl.setHasError(true);
					RC_Rating.setStatus(e.getMessage());
					e.printStackTrace();
				}
			}
		});
		threadPool.shutdown();
	}

	private static void deleteAggregated(final RC_ThreadControl threadCtl, final DBconnect db, final String sql) {
		ExecutorService threadPool = Executors.newSingleThreadExecutor();
		threadPool.submit(new Runnable() {
			public void run() {		
				try {
					threadCtl.setDeleteAggregatedDone(false);
					
					RC_Rating.setStatus(MessageConstants.RC_RATING.DELETING_AGG_RC);
					db.Update(sql);
					RC_Rating.setStatus(MessageConstants.RC_RATING.DELETED_OLD_RC);
				
					threadCtl.setDeleteAggregatedDone(true);
				} catch (SQLException e) {
					threadCtl.setHasError(true);
					RC_Rating.setStatus(e.getMessage());
					e.printStackTrace();
				}
			}
		});
		threadPool.shutdown();
	}

	public static void createTempTable(final RC_ThreadControl threadCtl, final DBconnect db, final String beginDate, final String shortBeginDate, final String endDate, final Statement st, final xmlParser xml, final String schema, final String schemaData, final boolean fullCycle, final boolean allSubs) {
		ExecutorService threadPool = Executors.newSingleThreadExecutor();
		threadPool.submit(new Runnable() {
			public void run() {		
				try {
					threadCtl.setCreateTempDone(false);

					RC_Rating.setStatus(MessageConstants.RC_RATING.TEMP_DATA_CREATING);
					DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss");
					RC_Rating.setStatus("[Creating data]: " + dateFormat.format(Calendar.getInstance().getTime()));
			
					//Neu isRateLastPOday = true thi tinh cuoc ngay cuoi cung cua PO.
					//Vi du, goi ALo het han vao ngay 10.2 - luc 12h trua. Neu isRateLastPOday = true thi khach hang dung goi
					//cuoc nay van bi tinh cuoc RC ngay 10.2, con neu isRateLastPOday = false thi ko tinh
					boolean isRateLastPOday = xml.getConfig("rateMode", "rateLastPOday").equals("1");
					String sLastPODay = isRateLastPOday? "+1" : "";
					
					String sql = "TRUNCATE TABLE " + schemaData + "temp_RC_rating";
					db.Update(sql);
			
					String sEndDate;
					if (fullCycle) 
						sEndDate = endDate;
					else 
						sEndDate = "decode(sign(" + endDate + " - sysdate), 1, sysdate, " + endDate + ")";
			
					String notAllSub="";
					if (!allSubs) 
						notAllSub = " AND (d.from_date BETWEEN " + beginDate + " AND " + endDate + " OR  d.to_date BETWEEN " + beginDate + " AND " + endDate + ")";
			
//					sql = "INSERT INTO " + schemaData + "temp_RC_rating " +
//						  "SELECT /*+ PARALLEL(, 2) */ subscriber_id, subscriber_no, product_offer_version_id, status_id," +
//						  "		     (decode(sign(po_to_date-status_start_date), 1, " +
//						  "		     (to_date(to_char(status_end_date,'ddMMyyyy'),'ddMMyyyy')-decode(sign(status_start_date-" + beginDate + "), 1, to_date(to_char(status_start_date,'ddMMyyyy'),'ddMMyyyy'), " + shortBeginDate + "))," +
//						  "			 0)) duration," +
//						  "		  rc, vat_rate, currency_id " +
//						  "FROM" +
//						  "		(SELECT /*+ PARALLEL(, 2) */ subscriber_id, subscriber_no, product_offer_version_id, status_id," +
//				          "				decode(sign(po_from_date-status_start_date), 1, po_from_date, status_start_date) status_start_date," +
//				          "				decode(sign(po_to_date-status_end_date), 1, status_end_date, po_to_date) status_end_date," +
//				          "				rc, vat_rate, currency_id, po_to_date " +
//				          "		FROM" + 
//				          "			(SELECT /*+ PARALLEL(, 2) */ subscriber_id, subscriber_no, product_offer_version_id, status_id," +
//				          "					po_from_date, po_to_date, rc, vat_rate, currency_id, status_start_date," +
//				          "					decode(sign(status_end_date-" + sEndDate + " +1),1, " + sEndDate + "+1, status_end_date) status_end_date" +
//				          "			FROM" +
//				          "				(SELECT /*+ PARALLEL(C, 2) PARALLEL(D, 2) PARALLEL(A, 2) PARALLEL(B, 2) */ a.subscriber_id, a.subscriber_no, b.product_offer_version_id, c.status_id," +
//				          "						decode(sign(b.from_date-d.from_date), 1, b.from_date, d.from_date) po_from_date," +
//				          "						decode(sign(b.to_date-d.to_date), 1, d.to_date" + sLastPODay + ", b.to_date" + sLastPODay + ") po_to_date," +
//				          "						c.start_date status_start_date, b.rc, b.vat_rate, b.currency_id," +
//				          "						nvl(c.end_date, " + sEndDate + "+1) status_end_date" +
//				          "				FROM " + schema + "subscriber a, " + schema + "product_offer_version b, " + schema + "subs_status_map c, " + schema + "subs_offer_map d" +
//				          "				WHERE a.subscriber_id = c.subscriber_id" +
//				          "				  AND a.subscriber_id = d.subscriber_id" +
//				          "				  AND b.product_offer_version_id = d.product_offer_version_id " + notAllSub +
//				          "				  AND c.start_date BETWEEN (SELECT /*+ PARALLEL(SUBS_STATUS_MAP, 2) */  nvl(max(start_date)," + beginDate + ") FROM " + schema + "subs_status_map" +
//				          "											WHERE subscriber_id = a.subscriber_id AND start_date < " + beginDate + ")" +
//				          "			                        AND " + sEndDate +
//				          "				)" +
//				          "			)" +
//				          "		) " +
//				          "WHERE status_end_date >= decode(sign(status_start_date-" + beginDate + "), 1, status_start_date, " + beginDate + ")";
					
					sql = "INSERT INTO " + schemaData + "temp_RC_rating " +
							  "SELECT /*+ PARALLEL(, 2) */ subscriber_id, subscriber_no, offer_id, status_id," +
							  "		     (decode(sign(status_end_date-status_start_date), 1, " +
							  "		     (to_date(to_char(status_end_date,'ddMMyyyy'),'ddMMyyyy')-decode(sign(status_start_date-" + beginDate + "), 1, to_date(to_char(status_start_date,'ddMMyyyy'),'ddMMyyyy'), " + shortBeginDate + "))," +
							  "			 0)) duration," +
							  "		  rc, vat_rate, currency_code " +
							  "FROM" +
							  "		(SELECT /*+ PARALLEL(, 2) */ subscriber_id, subscriber_no, offer_id, status_id," +
					          "				decode(sign(po_from_date-status_start_date), 1, po_from_date, status_start_date) status_start_date," +
					          "				decode(sign(po_to_date-status_end_date), 1,po_to_date ,status_end_date ) status_end_date," +
					          "				rc, vat_rate, currency_code, po_to_date " +
					          "		FROM" + 
					          "			(SELECT /*+ PARALLEL(, 2) */ subscriber_id, subscriber_no, offer_id, status_id," +
					          "					po_from_date, po_to_date, rc, vat_rate, currency_code, status_start_date," +
					          "					decode(sign(status_end_date-" + sEndDate + " +1),1, " + sEndDate + "+1, status_end_date) status_end_date" +
					          "			FROM" +
					          "				(SELECT /*+ PARALLEL(C, 2) PARALLEL(D, 2) PARALLEL(A, 2) PARALLEL(B, 2) */ a.subscriber_id, a.subscriber_no, b.offer_id, c.status_id," +
					          "						decode(sign(b.sales_effective_time-d.from_date), 1, b.sales_effective_time, d.from_date) po_from_date," +
					          "						decode(sign(b.sales_expiration_time-d.to_date), 1, d.to_date" + sLastPODay + ", b.sales_expiration_time" + sLastPODay + ") po_to_date," +
					          "						c.start_date status_start_date, b.rc, b.vat_rate, b.currency_code," +
					          "						nvl(c.end_date, " + sEndDate + "+1) status_end_date" +
					          "				FROM " + schema + "subscriber a, " + schema + "product_offer b, " + schema + "subs_status_map c, " + schema + "subs_offer_map d" +
					          "				WHERE a.subscriber_id = c.subscriber_id" +
					          "				  AND a.subscriber_id = d.subscriber_id" +
					          "				  AND b.offer_id = d.product_offer_id " + notAllSub +
					          "				  AND c.start_date BETWEEN (SELECT /*+ PARALLEL(SUBS_STATUS_MAP, 2) */  nvl(max(start_date)," + beginDate + ") FROM " + schema + "subs_status_map" +
					          "											WHERE subscriber_id = a.subscriber_id AND start_date < " + beginDate + ")" +
					          "			                        AND " + sEndDate +
					          "				)" +
					          "			)" +
					          "		) " +
					          "WHERE status_end_date >= decode(sign(status_start_date-" + beginDate + "), 1, status_start_date, " + beginDate + ")";
			
					db.Select(sql, true, st);
					
					RC_Rating.setStatus("[Data created ]: " + dateFormat.format(Calendar.getInstance().getTime()));
					threadCtl.setCreateTempDone(true);

				} catch (SQLException e) {
					threadCtl.setHasError(true);
					RC_Rating.setStatus(e.getMessage());
					e.printStackTrace();
				}
			}
		});
		threadPool.shutdown();
	}

	public static ResultSet getSubscriber(DBconnect db, String beginDate, String endDate, Statement st, String schemaData) {
		RC_Rating.setStatus(MessageConstants.RC_RATING.GETTING_ALL_MTR);
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss");
		RC_Rating.setStatus("[Load staring]: " + dateFormat.format(Calendar.getInstance().getTime()));
		
		ResultSet rs = null;
		try {
//			String sql = "SELECT subscriber_id, subscriber_no, product_offer_version_id, status_id, sum(duration) duration, rc, vat_rate, currency_id " +
//						 "FROM " + schemaData + "temp_RC_rating " +
//						 "GROUP BY subscriber_id, subscriber_no, product_offer_version_id, status_id,rc, vat_rate, currency_id";
			
			String sql = "SELECT subscriber_id, subscriber_no, offer_id, status_id, sum(duration) duration, rc, vat_rate, currency_code " +
					 "FROM " + schemaData + "temp_RC_rating " +
					 "GROUP BY subscriber_id, subscriber_no, offer_id, status_id,rc, vat_rate, currency_code";
			
			rs = db.Select(sql, true, st);

			RC_Rating.setStatus("[Loaded all at]: " + dateFormat.format(Calendar.getInstance().getTime()));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	//Tổng hợp cước thuê bao
	public static void aggregateRC(DBconnect db, String beginDate, String schemaData, boolean bulkLoad) {
		try {
   			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss");
   			RC_Rating.setStatus(MessageConstants.RC_RATING.RC_AGGREGATION + " \n[Start aggretation time]: " + dateFormat.format(Calendar.getInstance().getTime()));

			String bill_month = beginDate.substring(9, 17);
			String sql = "INSERT INTO " + schemaData + "aggregated_rc " +
						 "SELECT subscriber_id, subscriber_no, currency_code, sum(rc) rc, sum(vat) vat, to_date('" + bill_month + "','ddMMyyyy') bill_month " +
						 "FROM " + schemaData + "rated_rc " +
						 "WHERE bill_month = to_date('" + bill_month + "','ddMMyyyy')" +
						 "GROUP BY subscriber_id, subscriber_no, currency_code";
			db.Update(sql);
			if (!bulkLoad) db.commit();

   			RC_Rating.setStatus("[End aggretation time  ]: " + dateFormat.format(Calendar.getInstance().getTime()));
   			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public static void insertIntoDB(DBconnect db, String schemaData, int subscriber_id, String subscriber_no, int product_offer_version_id, String bill_month,
									double ratedRC, double ratedVAT, int currency_id, int status_id, int number_of_days, String full_cycle) {
		try {
//			String sql =  "INSERT INTO " + schemaData + "rated_rc (subscriber_id, subscriber_no, product_offer_version_id, bill_month, rc, vat, currency_id, status_id, number_of_days, full_cycle) " +
//					       "VALUES (" + Integer.toString(subscriber_id) + 
//						   "	,'" + subscriber_no + "'" +
//						   "	," + Integer.toString(product_offer_version_id) + 
//						   "	, to_date('" + bill_month + "','ddMMyyyy')" + 
//						   "	," + Double.toString(ratedRC) +
//						   "	," + Double.toString(ratedVAT) +
//						   "	," + Integer.toString(currency_id) +
//						   "	," + Integer.toString(status_id) + 
//						   "	," + Integer.toString(number_of_days) + 
//						   "	,'" + full_cycle + "')";
			
			String sql =  "INSERT INTO " + schemaData + "rated_rc (subscriber_id, subscriber_no, offer_id, bill_month, rc, vat, currency_code, status_id, number_of_days, full_cycle) " +
				       "VALUES (" + Integer.toString(subscriber_id) + 
					   "	,'" + subscriber_no + "'" +
					   "	," + Integer.toString(product_offer_version_id) + 
					   "	, to_date('" + bill_month + "','ddMMyyyy')" + 
					   "	," + Double.toString(ratedRC) +
					   "	," + Double.toString(ratedVAT) +
					   "	," + Integer.toString(currency_id) +
					   "	," + Integer.toString(status_id) + 
					   "	," + Integer.toString(number_of_days) + 
					   "	,'" + full_cycle + "')";
			
			db.Update(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
