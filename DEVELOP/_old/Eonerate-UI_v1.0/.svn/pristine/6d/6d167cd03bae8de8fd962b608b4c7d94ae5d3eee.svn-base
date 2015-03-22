package eonerateui.controller.rc_rating;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import eonerateui.controller.xml.xmlParser;
import eonerateui.db.RcRatingDAO;
import eonerateui.db.pool.DBconnect;
import eonerateui.gui.main.MainApplicationUI;
import eonerateui.gui.menu.rating.RC_Rating;
import eonerateui.util.CodeConstants;
import eonerateui.util.MessageConstants;
import eonerateui.util.ProgramConfig;
import eonerateui.util.RC_Tariff;

public class RC_Process {
	private static Logger logger = Logger.getLogger("RC_Process");
	static final int ROUND_DIGIT = 100; //2 decimal places =100, 3 =1000, 4 =10000
	static final int FETCH_SIZE	 = 2000;// for setFetchSize of resultset
	
	private boolean isFirstLine = true; 	//first line means: 1. Need to create file; 2. Write header of CSV file.
	private BufferedWriter bwCSV;
	private boolean isFileValid; 		  	//check valid of file, if invalid, exist process
	private String fileCSV = null;  		//ten file CSV 
	private String filePrefix = null; 		//ten file (khong bao gom ext) cua bad va log file
	
	private boolean allSubs 	= true;
	private int billMonth 		= 0;
	private int billYear 		= 0;
	private boolean fullCycle 	= true;
	private int packageSelected = 0;
	private boolean bulkLoad 	= true;
	private xmlParser xml		= null;
	private boolean doneRating  = true;
	
	private DBconnect db;
	private String schema, schemaData;
	private String ctlURL, logURL, badURL, vas_service;
	private HashMap<String, RC_Tariff> mapTariff;

	boolean isRunInShedule = false;
	private Timer timerDay, timerNight;
	
	public void close() throws SQLException {
		this.isFirstLine = true; 	
		this.bwCSV 		 = null;
		this.isFileValid = false;		  	
		this.fileCSV 	 = null;  	
		
		setDoneRating(true);

		//nếu là chạy theo schedule thì không được reset các biến này, để còn chạy lần sau
		if (!isRunInShedule) {
			if (this.db!=null) db.close();
			
			this.allSubs 		 = true;
			this.billMonth 		 = 0;
			this.billYear 		 = 0;
			this.fullCycle 		 = true;
			this.packageSelected = 0;
			this.bulkLoad 		 = true;
			this.xml			 = null;
			mapTariff 			 = null;
		}
	}
	
	public RC_Process(boolean allSubs, int billMonth, int billYear, boolean fullCycle, int packageSelected, boolean bulkLoad) throws IOException {
		//grant all values for variables
		this.allSubs 		= allSubs;
		this.billMonth 		= billMonth;
		this.billYear 		= billYear;	
		this.fullCycle		= fullCycle;
		this.packageSelected= packageSelected;
		this.bulkLoad 		= bulkLoad;
		this.xml = new xmlParser(ProgramConfig.getConfigFile());
		
       	ctlURL = ProgramConfig.getRC_CtlURL();
       	logURL = ProgramConfig.getRC_LogURL();
       	badURL = ProgramConfig.getRC_BadURL();
       	vas_service = ProgramConfig.getVasService();
	}
		
	public void rateScheduleRC() throws IOException, SQLException, ParseException {
		isRunInShedule = true;
		
		//set timer for schedule rating of dayTime and nightTime
		timerDay   = new Timer();
		timerNight = new Timer();
		
		setTimeSchedule(timerDay, "am", true);
		setTimeSchedule(timerNight, "pm", false);
	}
	
	private void setTimeSchedule(Timer timer, String sTime, boolean dayTime) throws SQLException, ParseException {
		int value = Integer.parseInt(xml.getConfig("runMode", sTime + "Start"));
		
		String sNow = RcRatingDAO.getNow(db);
		
		Calendar cal = Calendar.getInstance();
		if (sNow != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		    cal.setTime(sdf.parse(sNow));
		}
		int hour = cal.get(Calendar.HOUR_OF_DAY);//get the hour number of the day, from 0 to 23
		int minute = cal.get(Calendar.MINUTE);
		int second = cal.get(Calendar.SECOND);
		int now = (hour * 3600) + (minute * 60) + second;

		int startHour = (int) Math.floor(value/60);
		int startMinute = value % 60;
		int startTime = (startHour * 3600) + (startMinute * 60);

		int minRepeat = Integer.parseInt(xml.getConfig("runMode", sTime + "Repeat"));
		long secondRepeat = minRepeat * 60;
		long initialMilisecondDelay = 1000 * (secondRepeat - ((now - startTime) % secondRepeat));

		timer.schedule(new RemindTask(dayTime), initialMilisecondDelay, secondRepeat * 1000); 	//	delay the task 0 second, and then run task every pmRepeat minutes 			
	}

	//class for TimerTask setting
	class RemindTask extends TimerTask {
		private boolean dayTime; 

	    RemindTask(boolean _dayTime) {
	       this.dayTime = _dayTime;
	    }
	    
        public void run() {
			if (dayTime == dayTime()) {
				runBySchedule();
			}
        }
    }
	
	//return true if day time, false if night time
	private boolean dayTime() {
		Calendar cal = Calendar.getInstance(); //this is the method we should use, not the Date(), because it is desperated.
		 
		int hour = cal.get(Calendar.HOUR_OF_DAY);//get the hour number of the day, from 0 to 23
		int minute = cal.get(Calendar.MINUTE);
		int now = hour * 60 + minute;
		
		int valueAM = Integer.parseInt(xml.getConfig("runMode", "amStart"));
		int hourAM = (int) Math.floor(valueAM/60);
		int minAM = valueAM % 60;

		int valuePM = Integer.parseInt(xml.getConfig("runMode", "pmStart"));
		int hourPM = (int) Math.floor(valuePM/60);
		int minPM = valuePM % 60;

		// nightTime from 18h00 pm till to 5h59 am so if hourPM is 0-5, plus 24h for comperating to dayTime
		if (hourPM < 6) {
			hourPM = hourPM + 24;
		}
		
		return ((now >= hourAM*60 + minAM) && (now <= hourPM*60 + minPM));
	}
	
	//do RC rating bu schedule here
	private void runBySchedule() {
		// only do the task as schedule if it is not running
		if (isDoneRating())
		{
			try {
				rateRC();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	//rating here
	public void rateRC() throws SQLException, IOException {
		//setting status for rating is not done
		setDoneRating(false);

		//Database connecting
		db= new DBconnect();
		
		//Neu la loader thi autocommit = true;
		if (!bulkLoad) db.setAutoCommit();
		
		schema = db.getDbconfig().getDb_schema();
		schemaData = db.getDbconfig().getDb_data_schema();
		
		RC_Rating.setIndeterminate(true);
		RC_Rating.clearStatus();
		RC_Rating.setStatus("Database Connected!");
		
		//Setting first day of billing cycle and end day
		String beginDate = getBeginDate();
		String endDate = getEndDate();
		StringBuilder loaderCommand = new StringBuilder();
		
		try {
			//Update log of rating.
			RcRatingDAO.updateLog(db, bulkLoad, schemaData);

			//Getting total of subscriber that will be rated.
			int subsCount = RcRatingDAO.getTotalSubs(db, beginDate, endDate, fullCycle, allSubs, schema);
			
			if (subsCount >0) {
				//Load product_version
				DBconnect dbDeleteDtl = new DBconnect();
				DBconnect dbDeleteAgg = new DBconnect();
				DBconnect dbCreateTem = new DBconnect();

				Statement stmDur;
				stmDur = db.createStatement();
				ResultSet rsDur = prepareEnviront(beginDate, endDate, dbDeleteDtl, dbDeleteAgg, dbCreateTem, stmDur);
				
				if (rsDur != null) {
					//commit if loader, if insertBulk, commit sau khi da tinh toan xong
	           		if (!bulkLoad) {
	           			dbDeleteDtl.commit();
	           			dbDeleteAgg.commit();
	           			dbCreateTem.commit();
	           		}

					//Getting total of subscriber that will be rated.
					RC_Rating.setStatus(String.format(MessageConstants.RC_RATING.GETTING_TOTAL_ROWS, subsCount));
					rsDur.afterLast();
					int recordCount;
					if (rsDur.previous()) recordCount = rsDur.getRow();
					else recordCount =0;
					
	       			if (recordCount>0) {
						RC_Rating.setStatus(String.format(MessageConstants.RC_RATING.TOTAL_ROWS, recordCount));

						//statement for rsRC
						Statement stmRC = null;

						//batch insert number rated_rc per time.
						Integer bulkLoadNo = StringUtils.isNumeric(xml.getConfig("process", "bulkInsert")) ? Integer.parseInt(xml.getConfig("process", "bulkInsert")) : 1000;
						if (bulkLoad) db.setBulk(bulkLoadNo); 
						
	           			// Move to beginning and start rating
						RC_Rating.setStatus("Rating... ");
						RC_Rating.setIndeterminate(false);
						RC_Rating.setProgressMax(recordCount);  
						
						int i, subs_id, PO_version_id, status_id, currency_id, duration;
						double rc, vat_rate;
						String subs_no;
						
						DecimalFormat df = new DecimalFormat("#,###");
			            while(rsDur.previous()){
			            	
			            	//get record position, set to value of progressbar, and status
			            	i = recordCount- rsDur.getRow(); 
			            	RC_Rating.setProgressValue(i);
			            	if ((i % bulkLoadNo)==0)
			            		RC_Rating.setStatus(df.format(i) + "/" + df.format(recordCount) + MessageConstants.RC_RATING.RATED_ROWS);
			            	
			            	//subscriber_id, subscriber_no, product_offer_version_id, status_id, rc, vat_rate, currency_id, duration
			            	subs_id    	   = rsDur.getInt("subscriber_id");
			            	subs_no	   	   = rsDur.getString("subscriber_no");
			            	PO_version_id  = rsDur.getInt("offer_id");
			            	status_id 	   = rsDur.getInt("status_id");
			            	rc		  	   = rsDur.getDouble("rc");
			            	vat_rate	   = rsDur.getDouble("vat_rate");
			            	currency_id	   = rsDur.getInt("currency_code");
			            	duration 	   = rsDur.getInt("duration");

			            	//Tinh cuoc thue bao
		            		if (duration>=0) {		            			 
		            			rating(subs_id,subs_no,PO_version_id, status_id, duration, rc, vat_rate, currency_id, stmRC, beginDate);
		            		}
			            }
			            	            
			            if (stmDur != null) stmDur.close();
			            rsDur.close();
			           
		           		RC_Rating.setStatus(df.format(recordCount) + "/" + df.format(recordCount) + MessageConstants.RC_RATING.RATED_ROWS);
		           		if (bulkLoad) {
				            RC_Rating.setStatus(MessageConstants.RC_RATING.BULK_INSERT_DONE);
			            }
			            else {
			            	//call SQL loader
			            	if (bwCSV != null) {
			            		Process p = null;
								try {
									bwCSV.close();
									
						           	RC_Rating.setStatus(MessageConstants.RC_RATING.SQLLDR_IS_LOADING);
						           	
						           	String logFile = logURL + filePrefix + ".log";
						           	String badFile = badURL + filePrefix + ".bad";
						           	
						           	//save lastest tracking file to xml
						           	xml.setConfig("logFile", logFile);
						           	xml.setConfig("badFile", badFile);
						           	
						           	/*
						           	 * NOTE: to use sql loader, command must be in case sensitive. (unix do not understand SQLLDR)
						           	 */
									loaderCommand.append("sqlldr " + db.getDbconfig().getDb_user() + "/" + db.getDbconfig().getDb_pass() + "@" + xml.getConfig("process", "loadTNS") + " ");
									loaderCommand.append("control = '" + ctlURL + "' ");
								    loaderCommand.append("log = '" + logFile + "' ");
								    loaderCommand.append("bad = '" + badFile + "' ");
								    loaderCommand.append("data = '" + fileCSV + "'");
								    
								    p = Runtime.getRuntime().exec(loaderCommand.toString());
									BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
								    BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
								     
								    // read the output from the command
							        String s = null;
							        int count = 0;
							        String lastCommit = null;
							        while ((s = stdInput.readLine()) != null) {
							        	count++;
							        	if(count == 1000){
							        		RC_Rating.setStatus(s);
							        		count = 0;
							        	}
							        	lastCommit = s;
							        }
							        if(stdInput.readLine() == null){
							        	RC_Rating.setStatus(lastCommit);
							        	RC_Rating.setStatus(MessageConstants.RC_RATING.SQLLDR_DONE);
							        } 
							        stdInput.close();
							        
							        boolean noError = true;
							        // read any errors from the attempted command
							        while ((s = stdError.readLine()) != null) {
							        	RC_Rating.setStatus(s);
							        	noError = false;
							        }
							        stdError.close();

							        if (!noError) {
						           		RC_Rating.setStatus(MessageConstants.RC_RATING.LOADER_HAS_PROBLEMS);
							        }
							        
								} catch (IOException e) {	  
									db.rollback();					//Error -> rollback actions
									logger.error("loaderCommand :" + loaderCommand.toString());
									e.printStackTrace();
								} finally {
									if (p!=null) p.destroy();
								}
			            	}
			            }
		           		
		           		//có tổng hợp cước RC sau khi tính
		           		if (xml.getConfig("process", "aggregate").equals(Integer.toString(CodeConstants.RC_RATING.AGGREGATE_WHEN_DONE))) {
		           			RcRatingDAO.aggregateRC(db, beginDate, schemaData, bulkLoad);
		           		}
		           		
		           		if (bulkLoad) {
			           		RC_Rating.setStatus(MessageConstants.RC_RATING.COMMITTING_RESULTS);
			           		dbDeleteDtl.commit();
			           		dbDeleteAgg.commit();
			           		dbCreateTem.commit();
			            	db.commitBulk();
		           		}
		           		
		           		RC_Rating.setStatus(MessageConstants.RC_RATING.RC_RATING_DONE);
			            RC_Rating.setProgressValue(recordCount);
					}
					else {
			            if (stmDur != null) stmDur.close();
						RC_Rating.setStatus(MessageConstants.RC_RATING.NO_SUBSCRIBER_FOUND);
						RC_Rating.setIndeterminate(false);
					}	
				}
				else {
					dbDeleteDtl.rollback();
					dbDeleteAgg.rollback();
					dbCreateTem.rollback();
				}
			}
			
			MainApplicationUI.updateLogTimesRC();
			
		} catch (SQLException e) {
			if (db!=null) db.close();
			e.printStackTrace();
		} 		

		//close all
		close();
	}
	
	private ResultSet prepareEnviront(String beginDate, String endDate, DBconnect dbDeleteDtl, DBconnect dbDeleteAgg, DBconnect dbCreateTem, Statement stmDur) {
		ResultSet rsDur = null;
		try {
			//Load product_version
			mapTariff = RcRatingDAO.loadProductRC(db, beginDate, endDate, packageSelected, schema, vas_service);
			
			RC_ThreadControl threadCtl = new RC_ThreadControl();
			RcRatingDAO.deleteOldRC(threadCtl, dbDeleteDtl, dbDeleteAgg, beginDate.substring(9, 17),  beginDate, endDate, packageSelected, schema, schemaData, vas_service, allSubs, fullCycle);
			
			//Lay toan bo subscriber_id, ngay trang thai, goi cuoc, rc, vat, vat_rate ra vao bang tam.
			RcRatingDAO.createTempTable(threadCtl, dbCreateTem, beginDate, getShortBeginDate(), endDate, stmDur, xml, schema, schemaData, fullCycle, allSubs);
			
			boolean isBreak = false;
			while (true) {
				if (threadCtl.isDone()) {
					break;
				} 
				else if (threadCtl.hasError()) {
					isBreak = true;
					break;
				}
				
				//set priority cho thread dang chay thap nhat, uu tien 2 thread con lai
				Thread.currentThread().setPriority(Thread.MIN_PRIORITY);
				//set time sleep tranh viec check lien tuc, tang CPU
			    Thread.sleep(100);
			    System.out.print("");
			}

			Thread.currentThread().setPriority(Thread.MAX_PRIORITY);
			
			if (!isBreak) {
				//load tat ca subscriber_id, ngay trang thai, goi cuoc, rc, vat, vat_rate ra de tinh toanT
				stmDur.setFetchSize(FETCH_SIZE);								//can tunning FetchSize nay khi de dam bao toc do
				rsDur = RcRatingDAO.getSubscriber(db, beginDate, endDate, stmDur, schemaData); 
			} 

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		return rsDur;
	}

	private String getBeginDate() {
		String beginDate;
		if (billMonth<10) 
			beginDate = "010" + Integer.toString(billMonth) + Integer.toString(billYear);
		else 
			beginDate = "01" + Integer.toString(billMonth) + Integer.toString(billYear);
		
		return "to_date('" + beginDate + "000001','ddMMyyyyHH24MISS')";
	}

	private String getShortBeginDate() {
		String beginDate;
		if (billMonth<10) 
			beginDate = "010" + Integer.toString(billMonth) + Integer.toString(billYear);
		else 
			beginDate = "01" + Integer.toString(billMonth) + Integer.toString(billYear);
		
		return "to_date('" + beginDate + "','ddMMyyyy')";
	}

	private String getEndDate() {
		//neu fullCycle = false, endDate van lay gia tri la cuoi thang chu ko lay ngay hien thoi
		//li do: neu lay thoi gian hien thoi, gia tri thoi gian se la tren may tinh cuoc chu khong phai tren may chu DB
		//va co the se khong trung voi sysdate. Vay nen, van lay cuoi thang va sau do trong lenh select se bien thanh
		//chi lay den sysdate
		
		String endDate=null;
		try {
			if (billMonth < 12) {
				if (billMonth<9) 
					endDate = "010" + Integer.toString(billMonth+1) + Integer.toString(billYear);
				else
					endDate = "01" + Integer.toString(billMonth+1) + Integer.toString(billYear);				
	
				DateFormat formatter = new SimpleDateFormat("ddMMyyyy");
				Calendar cld = Calendar.getInstance();
				cld.setTime(formatter.parse(endDate));
								
				int x = -1;
				cld.add(Calendar.DAY_OF_YEAR, x);	

				endDate = formatter.format(cld.getTime());
			}
			else 
				endDate = "3112" + Integer.toString(billYear);
		} catch (ParseException e) {
			e.printStackTrace();
		}	
		return "to_date('" + endDate + "235959','ddMMyyyyHH24MISS')";
	}
	
	private void rating(int subscriber_id, String subscriber_no, int product_offer_version_id, int status_id, int number_of_days,
        				double rc, double vat_rate, int currency_id, Statement st, String beginDate) throws SQLException 
    {
		String key = Integer.toString(product_offer_version_id) + "_" +  Integer.toString(status_id) + "_" + Integer.toString(number_of_days);
		if (mapTariff.containsKey(key)) {
    		
    		//get all necessary fields need for rating
        	double tariff_value 	= mapTariff.get(key).getTariffValue();
        	int RC_tariff_type_id 	= mapTariff.get(key).getRCTariffTypeID();
        	String full_cycle 		= mapTariff.get(key).getFullCycle();
        	
        	if (full_cycle==null) full_cycle="0";    
    		//insert to rated_rc if bulkload, save file CSV if loader (kể cả rsRC.getString("full_cycle")=="1" thì vẫn phải update cho bản ghi hiện tại
    		updateRC(subscriber_id, subscriber_no, tariff_value, product_offer_version_id, rc, vat_rate, currency_id, RC_tariff_type_id, status_id, number_of_days, full_cycle, beginDate);
		}
    }
	
	//update rated RC value into DB
	private void updateRC(int subscriber_id, String subscriber_no, double tariff_value, int product_offer_version_id, 
			         	  double RC, double VAT_rate, int currency_id, int RC_tariff_type_id, int status_id, int number_of_days, String full_cycle, String beginDate) throws SQLException 
	{
		double ratedRC=0, ratedVAT=0;
		String bill_month = beginDate.substring(9, 17);

		//Nếu full_cycle -> cước RC này luôn tròn tháng.
		if (full_cycle.equals("1")) {
			ratedRC = RC;
		}
		//Nếu không phải là full_cycle, tính bình thường
		else {
	        switch (RC_tariff_type_id) {
	        	case CodeConstants.RC_RATING.PRORATE:
	        	    SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyy");
	        		Calendar cld = Calendar.getInstance();
	        		
					try {
						cld.setTime(sdf.parse(bill_month));
					} catch (ParseException e1) {
						e1.printStackTrace();
					}
	 
	      		    ratedRC  = (double) Math.round((number_of_days / (double) cld.getActualMaximum(Calendar.DAY_OF_MONTH) * RC) * ROUND_DIGIT) / ROUND_DIGIT;
	                break;
	
	        	case CodeConstants.RC_RATING.DIV_FIX_DAY:
	        		ratedRC  = (double) Math.round((number_of_days / tariff_value * RC) * ROUND_DIGIT) / ROUND_DIGIT;
	                break;
	
	        	case CodeConstants.RC_RATING.PERCENT:
	        		ratedRC  = (double) Math.round((tariff_value * RC / 100) * ROUND_DIGIT) / ROUND_DIGIT;
	                break;
	
	        	case CodeConstants.RC_RATING.FIX_AMOUNT:
	        		ratedRC  = (double) Math.round(tariff_value * ROUND_DIGIT) / ROUND_DIGIT;
	                break;
	        }
		}
        
        //VAT rating
		ratedVAT = ratedRC * VAT_rate/100;
				
		if (bulkLoad) {
			//insert into oracle
			RcRatingDAO.insertIntoDB(db, schemaData, subscriber_id, subscriber_no, product_offer_version_id, bill_month, ratedRC, ratedVAT, currency_id, status_id, number_of_days, full_cycle);
		}
		else {
			//write into CSV file
			try {
				if (isFirstLine) {
					File file;

					// if file doesnt exists, then create it; else get new file name (normally no duplicate file, because filename is current time of server at rating time)
					isFirstLine=false;
					isFileValid = false;
					while (!isFileValid) {
						filePrefix = getDataFileName();
						fileCSV	   = getDataPathName() + filePrefix + ".csv";

						file = new File(fileCSV);
						 
						if (!file.exists()) {
							file.createNewFile();
							bwCSV = new BufferedWriter(new FileWriter(file.getAbsoluteFile()));
							isFileValid = true;
						} 
					}
				}
				else bwCSV.newLine();
				
				//write rated RC 
				bwCSV.write(Integer.toString(subscriber_id) + ";" + 
							subscriber_no + ";" + 
						    Integer.toString(product_offer_version_id) + ";" + 
						    bill_month + ";"  + 
						    Double.toString(ratedRC) + ";" + 
						    Double.toString(ratedVAT) + ";" +
						    Integer.toString(currency_id) + ";" +
						    Integer.toString(status_id) + ";" +
						    Integer.toString(number_of_days) + ";" +
						    full_cycle + ";");
						    
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
		
	private String getDataFileName() {
		//get current date time
		String fileName = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());		
		return "DetailRC_" + fileName;
	}
	
	private String getDataPathName() {
		//get Path of CSV file (doc tu config da luu ra; o day tam lay constant dat o tren
		String pathFileName = xml.getConfig("process", "dataPath");
		return pathFileName;
	}

	private void setDoneRating(boolean done) {
		doneRating = done;
	}

	public boolean isDoneRating() {
		return doneRating;
	}
	
	public void releaseTimerSchedule() {
		if (timerDay != null) {
			timerDay.cancel();
			timerDay = null;
		}

		if (timerNight != null) {
			timerNight.cancel();
			timerNight = null;
		}
	}
}