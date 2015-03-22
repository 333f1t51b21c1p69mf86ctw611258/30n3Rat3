package eonerateui.controller.main;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.swing.JLabel;
import javax.swing.JTextArea;

import org.apache.log4j.Logger;

import eci.services.TestWS;
import eonerateui.controller.xml.ModifyXmlFile;
import eonerateui.controller.xml.ReadXmlFile;
import eonerateui.controller.xml.xmlParser;
import eonerateui.db.DiscountDAO;
import eonerateui.db.MainInforDAO;
import eonerateui.db.PriceDAO;
import eonerateui.db.UserAccountDAO;
import eonerateui.entity.search.output.DiscountSearchOutput;
import eonerateui.entity.search.output.PricesSearchOutput;
import eonerateui.entity.user.UserAccount;
import eonerateui.gui.menu.configuration.AdapterConfig;
import eonerateui.gui.menu.configuration.DBConfigRC;
import eonerateui.gui.menu.configuration.PipelineConfig;
import eonerateui.gui.menu.configuration.ProcessConfig;
import eonerateui.gui.util.MySortedJTable;
import eonerateui.gui.util.MyTableModel;
import eonerateui.util.IConstant;
import eonerateui.util.Log4jUtils;
import eonerateui.util.ProgramConfig;
import eonerateui.util.SecurityUtils;

public class MainProcessor {
	private static Logger logger = Logger.getLogger("MainProcessor");
	public static String startFileUrl = "";
	public static String stopFileUrl = "";
	public static Properties props = new Properties();
	private static TestWS testWs = new TestWS();
	public static String look_and_feel;
	
	public static void loadProperties() throws IOException {
		String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "program.conf";
		props.load(new FileInputStream(fileName));    
		startFileUrl = props.getProperty("start_file_url",startFileUrl);
		stopFileUrl = props.getProperty("stop_file_url",stopFileUrl);
		look_and_feel = props.getProperty("look_and_feel",look_and_feel);
	}
	
	/**
	 * TODO:  to update database configuration in OpenRate framework
	 * 
	 * @param username
	 * @param password
	 * @param host
	 * @param port
	 * @param serviceName
	 * 
	 * @author Son.Pham.Hong
	 * @date 07 Nov 2013
	 */
	
	public static int updateDatabaseConfig(String username, String password,
			String host, String port, String serviceName) {
		return ModifyXmlFile.updateDatabaseConfig(username, password, host, port, serviceName);
	}

	
	/**
	 * TODO: load information of db config in xml file
	 * 
	 * @author Son.Pham.Hong
	 * @date 08 Nov 2013
	 */
	
	public static DBConfigRC loadDBConfigFromXML(){
		try {
			return ReadXmlFile.loadDBConfigFromXML();
		} catch (IOException e) {
			logger.error("IOException", e);
			return new DBConfigRC();
		}
	}
	
	
	/**
	 * TODO:  to update pipeline configuration in OpenRate framework
	 * 
	 * @param pipelineOption
	 * 
	 * @author Son.Pham.Hong
	 * @date 07 Nov 2013
	 */
	
	public static int updatePipelineConfig(String pipelineOption) {
		return ModifyXmlFile.updateELCPipeline(pipelineOption);
	}
	
	/**
	 * TODO: to load ECI Pipeline information in XML file
	 * @return isActive: true or false
	 * 
	 * @author Son.Pham.Hong
	 * @date 08 Nov 2013
	 */
	
	public static String loadECIPipelineConfigFromXml(){
		try {
			return ReadXmlFile.loadECIPipelineConfigFromXml();
		} catch (IOException e) {
			logger.error("IOException", e);
			return "false";
		}
	}
	
	
	/**
	 * TODO: to load Input Adapter information in XML file
	 * @return: tableName
	 * 
	 * @author Son.Pham.Hong
	 * @date 11 Nov 2013
	 */
	
	public static AdapterConfig loadInputAdapterConfigurationFromXml(){
		try {
			return ReadXmlFile.loadInputAdapterConfigurationFromXml();
		} catch (IOException e) {
			logger.error("IOException", e);
			return new AdapterConfig();
		}
	}


	/**
	 * TODO authenticate user to login the system
	 * 
	 * @param username
	 * @param password
	 * @return login status
	 * 
	 * @author Son.Pham.Hong
	 * @date 12 Nov 2013
	 */
	
	public static UserAccount login(String username, String password){
		String encryptedPass = SecurityUtils.encryptedPass(username, password);
		UserAccount userAccount = UserAccountDAO.getUserAccount(username, encryptedPass);
		return userAccount;
	}


	
	/**
	 * TODO load process configuration from xml file
	 * 
	 * @return ArrayList<ProcessConfig>
	 * 
	 * @author Son.Pham.Hong
	 * @date 12 Nov 2013
	 */
	
	public static ArrayList<ProcessConfig> loadProcessConfig() {
		try {
			return ReadXmlFile.loadProcessConfig();
		} catch (IOException e) {
			logger.error("IOException", e);
			ArrayList<ProcessConfig> listProcessConfig = new ArrayList<ProcessConfig>();
			return listProcessConfig;
		}
	}
	
	/**
	 * TODO update process configuration from xml file
	 * 
	 * @param listProcess
	 * 
	 * @author Son.Pham.Hong
	 * @date 13 Nov 2013
	 */
	
	public static int updateProcessConfig(ArrayList<ProcessConfig> listProcess) {
		return ModifyXmlFile.updateProcessConfig(listProcess);
	}
	
	
	public static int updatePipelineConfig(ArrayList<PipelineConfig> listPipeline) {
		return ModifyXmlFile.updatePipelineConfig(listPipeline);
	}

	/**
	 * TODO load pipeline list configuration from xml file
	 * 
	 * @return login ArrayList<PipelineConfig>
	 * 
	 * @author Son.Pham.Hong
	 * @date 12 Nov 2013
	 */
	
	public static ArrayList<PipelineConfig> loadPipelineConfig() {
		try {
			return ReadXmlFile.loadPipelineConfig();
		} catch (IOException e) {
			logger.error("IOException", e);
			ArrayList<PipelineConfig> listPipelineConfig = new ArrayList<PipelineConfig>();
			return listPipelineConfig;
		}
	}
	
	
	/**
	 * TODO start Openrate frameword
	 * 
	 * @author Son.Pham.Hong
	 * @date 22 Nov 2013
	 */
	
	public static int startECI(){
		return testWs.startECI();
		}
	
	/**
	 * TODO stop Openrate Framword
	 * 
	 * @author Son.Pham.Hong
	 * @date 22 Nov 2013
	 */
	
	public static int stopECI(){
		return testWs.stopECI();
	}

	
	/**
	 * TODO	get all the prices model from PRICE_MODEL table
	 * 
	 * @return ArrayList<PricesSearchOutput>
	 * 
	 * @author Son.Pham.Hong
	 * @date 26 Nov 2013
	 */
	
	public static ArrayList<PricesSearchOutput> listAllPricesModels() {
		return PriceDAO.listAllPricesModels();
	}
	
	/**
	 * TODO	get all the discount model from DISCOUNT_MAP table
	 * 
	 * @return ArrayList<DiscountSearchOutput>
	 * @param discountIn
	 * @param zone
	 * 
	 * @author Son.Pham.Hong
	 * @date 26 Nov 2013
	 */
	
	public static ArrayList<DiscountSearchOutput> searchDiscount(String discountIn, String zone) {
		return DiscountDAO.searchDiscount(discountIn, zone);
	}

	
	
	/**
	 * TODO	get  the prices model from PRICE_MODEL table
	 * 
	 * @return ArrayList<PricesSearchOutput>
	 * @param productId
	 * 
	 * @author Son.Pham.Hong
	 * @date 26 Nov 2013
	 */
	public static ArrayList<PricesSearchOutput> searchPrice(String productId) {
		return PriceDAO.searchPrice(productId);
	}
	
	
	/**
	 * @TODO To load all username from previous input
	 * 
	 * @return
	 * 
	 * @author sonph
	 * @Date 04 Dec 2013
	 */
	public static List<String> loadUsernamesFromLog() {
		return Log4jUtils.loadUsernamesFromLog();
	}

	/**
	 * @TODO To load save username from last input
	 * 
	 * @return
	 * 
	 * @author sonph
	 * @Date 04 Dec 2013
	 */
	public static void saveUsernameToLog(String username) {
		Log4jUtils.saveUsernameToLog(username);
	}

	/**
	 * @TODO addSummaryData
	 * 
	 * @return
	 * 
	 * @author vinhdh
	 * @throws IOException 
	 * @Date 04 Dec 2013
	 */
	
	public static void addSummaryData(boolean nullValue, MyTableModel tableModel, MySortedJTable tableInfo) throws SQLException, IOException {
		String[] rowInfors   = {"Total CDRs were rerated today:", 
								"Voice", 
								"SMS", 
								"Data", 
								"Total MTRs were rated today:"};
		
		Object[][] data = new Object[rowInfors.length][2];
		if (nullValue) {
			for(int i = 0 ; i < rowInfors.length ; i ++){
				data[i][0] = rowInfors[i] + "  ";
				data[i][1] = "NA" + "  ";
			}
			tableModel.setData(data);
		}
		else {
			String[] rowValues = MainInforDAO.getValuesInfor();
			for(int i = 0 ; i < rowInfors.length ; i ++){
				data[i][0] = rowInfors[i] + "  ";
				data[i][1] = rowValues[i] + "  ";
			}
			tableModel.setData(data);
			tableInfo.getTable().setModel(tableModel);
			tableInfo.repaint();
		}
	}

	public static void clearRateTimeLog(JTextArea textLogTime) {
		textLogTime.setText("");
		MainInforDAO.clearRateTimeLog();
	}
	
	public static void updateLogTimesRC(JTextArea textLogTime, JLabel lblTimestoday) {
		String[] logTime = MainInforDAO.getLogTimesRC();
		textLogTime.setText(logTime[0]);
		lblTimestoday.setText(logTime[1]);
	}

	
	public static boolean hasRC_BadFile() throws IOException {
		boolean hasBad = false;
		xmlParser xml = new xmlParser(ProgramConfig.getConfigFile());
		String badFile = xml.getConfig("tracking", "badFile");
		
		File file = new File(badFile);
		if (file.exists()) hasBad=true;
		file = null;
		xml  = null;
		
		return hasBad;
	}

	public static String getRCLogFileName() throws IOException {
		xmlParser xml = new xmlParser(ProgramConfig.getConfigFile());
		String logFile = xml.getConfig("tracking", "logFile");
		xml  = null;
		return logFile;
	}

	public static String getRCBadFileName() throws IOException {
		xmlParser xml = new xmlParser(ProgramConfig.getConfigFile());
		String badFile = xml.getConfig("tracking", "badFile");
		xml  = null;
		
		return badFile;
	}

	public static int updateAdapaterConfig(String oldInputTable, String oldOutputTable, AdapterConfig adapterConfig) {
		return ModifyXmlFile.updateAdapaterConfig(oldInputTable, oldOutputTable, adapterConfig);
	}

}