package eonerateui.controller.xml;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import eonerateui.gui.menu.configuration.DBConfigRC;
import eonerateui.gui.menu.configuration.AdapterConfig;
import eonerateui.gui.menu.configuration.PipelineConfig;
import eonerateui.gui.menu.configuration.ProcessConfig;
import eonerateui.util.IConstant;


public class ReadXmlFile {
	private static Logger logger=Logger.getLogger("ReadXmlFile");
	public static String xmlUrl = "";
	public static Properties props = new Properties();
	
	public static void loadProperties() throws IOException {
		String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "program.conf";
		props.load(new FileInputStream(fileName));    
		xmlUrl = props.getProperty("config_url",xmlUrl);
	}
	
	/**
	 * TODO: to read db config in XML file
	 * @throws IOException 
	 */
	public static DBConfigRC loadDBConfigFromXML() throws IOException{
		loadProperties();
		String db_url = "";
		String username = "";
		String password = "";
		try {
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			File file = new File(xmlUrl);
			Document doc = docBuilder.parse(file);
			
			Node resourceNode = doc.getElementsByTagName(IConstant.XML_TAG.Resource).item(0);
			NodeList listResourceSubNode = resourceNode.getChildNodes();
			for(int i = 0 ; i < listResourceSubNode.getLength() ; i++){
				Node DataSourceFactory = listResourceSubNode.item(i);
				if(IConstant.XML_TAG.DataSourceFactory.equalsIgnoreCase(DataSourceFactory.getNodeName())){
					NodeList listDataSourceFactorySubNode = DataSourceFactory.getChildNodes();
					for(int j = 0 ; j < listDataSourceFactorySubNode.getLength(); j++){
						Node DataSource = listDataSourceFactorySubNode.item(j);
						if(IConstant.XML_TAG.DataSource.equalsIgnoreCase(DataSource.getNodeName())){
							NodeList listDataSourceSubNode = DataSource.getChildNodes();
							for (int k = 0 ; k < listDataSourceSubNode.getLength() ; k++){
								Node TestDb = listDataSourceSubNode.item(k);
								if(IConstant.XML_TAG.eOneRateDB.equalsIgnoreCase(TestDb.getNodeName())){
									NodeList listTestDBSubNode = TestDb.getChildNodes();
									for (int q = 0 ; q < listTestDBSubNode.getLength() ; q ++){
										Node node = listTestDBSubNode.item(q);
										if(IConstant.XML_TAG.db_url.equalsIgnoreCase(node.getNodeName())){
											db_url = node.getTextContent();
										}
										if(IConstant.XML_TAG.username.equalsIgnoreCase(node.getNodeName())){
											username = node.getTextContent();
										}
										if(IConstant.XML_TAG.password.equalsIgnoreCase(node.getNodeName())){
											password = node.getTextContent();
										}
									}
								}
							}
						}
					}
				}
			}
		   }catch (Exception e) {
			   logger.error("Exception", e);
		   }
		
		//jdbc:oracle:thin:@//192.168.6.207:1521/MAGICCALL
		if(!StringUtils.isEmpty(db_url)){
			String subStringValue = StringUtils.substringAfter(db_url, "@//");
			String host = StringUtils.substringBeforeLast(subStringValue, ":");
			String port = StringUtils.substringBeforeLast(StringUtils.substringAfter(subStringValue, ":"), "/");
			String serviceName = StringUtils.substringAfter(subStringValue , "/");
			
			DBConfigRC dbConfig = new DBConfigRC(username, password, host, port, serviceName);
			return dbConfig;
		}
		return new DBConfigRC();
		//return new DBConfig(username, password, host, port, serviceName);
	}
	
	
	/**
	 * TODO: to read pipeline config in XML file
	 * @throws IOException 
	 */
	public static String loadECIPipelineConfigFromXml() throws IOException{
		loadProperties();
		String isActive = "true";
		try {
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			File file = new File(xmlUrl);
			Document doc = docBuilder.parse(file);

			Node PipelineNode = doc.getElementsByTagName(IConstant.XML_TAG.PipelineList).item(0);
			NodeList listPipelineSubNode = PipelineNode.getChildNodes();
			for (int i = 0 ; i < listPipelineSubNode.getLength() ; i++){
				Node ELCPipelineNode = listPipelineSubNode.item(i);
				if (IConstant.XML_TAG.eOneRatePipeline.equals(ELCPipelineNode.getNodeName())){
					NodeList listELCPipelineSubNode = ELCPipelineNode.getChildNodes();
					for (int j = 0 ; j < listELCPipelineSubNode.getLength() ; j++){
						Node ActiveNode = listELCPipelineSubNode.item(j);
						if(IConstant.XML_TAG.Active.equalsIgnoreCase(ActiveNode.getNodeName())){
							isActive = ActiveNode.getTextContent();
						}
					}
				}
			}
			} catch (Exception e){
				logger.error("Exception", e);
				isActive = "false";
			}
		
		return isActive;
	}
	
	
	/**
	 * TODO: to load input adapter information from XML
	 * @throws IOException 
	 */
	public static AdapterConfig loadInputAdapterConfigurationFromXml() throws IOException{
		loadProperties();
		String inputTable = "";
		String outputTable = "";
		String initStatement = "";
		String inputValidateStatement = "";
		String outputValidateStatement = "";
		try {
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			File file = new File(xmlUrl);
			Document doc = docBuilder.parse(file);

			Node eOneRatePipelineNode = doc.getElementsByTagName(IConstant.XML_TAG.eOneRatePipeline).item(1);
			NodeList listELCPipelineSubNode = eOneRatePipelineNode.getChildNodes();
			for (int i = 0 ; i < listELCPipelineSubNode.getLength() ; i++){
				Node InputAdapterNode = listELCPipelineSubNode.item(i);
				
				/*
				 * load inputTable & initStatement 
				 */
				if (IConstant.XML_TAG.InputAdapter.equalsIgnoreCase(InputAdapterNode.getNodeName())){
					NodeList listInputAdapterSubNode = InputAdapterNode.getChildNodes();
					for (int j = 0 ; j < listInputAdapterSubNode.getLength() ; j++){
						Node DBInpAdapterNode = listInputAdapterSubNode.item(j);
						if(IConstant.XML_TAG.DBInpAdapter.equalsIgnoreCase(DBInpAdapterNode.getNodeName())){
							NodeList listDBInpAdapterSubNode = DBInpAdapterNode.getChildNodes();
							for(int k = 0 ; k < listDBInpAdapterSubNode.getLength() ; k++){
								Node node = listDBInpAdapterSubNode.item(k);
								if(IConstant.XML_TAG.ValidateStatement.equalsIgnoreCase(node.getNodeName())){
									inputValidateStatement = node.getTextContent();
								}
								if(IConstant.XML_TAG.InitStatement.equalsIgnoreCase(node.getNodeName())){
									initStatement = node.getTextContent();
								}
							}
						}
					}
				}
				
				/*
				 * load outputTable 
				 */
				if (IConstant.XML_TAG.OutputAdapter.equalsIgnoreCase(InputAdapterNode.getNodeName())){
					NodeList listInputAdapterSubNode = InputAdapterNode.getChildNodes();
					for (int j = 0 ; j < listInputAdapterSubNode.getLength() ; j++){
						Node DBInpAdapterNode = listInputAdapterSubNode.item(j);
						if(IConstant.XML_TAG.DBOutputAdapter.equalsIgnoreCase(DBInpAdapterNode.getNodeName())){
							NodeList listDBInpAdapterSubNode = DBInpAdapterNode.getChildNodes();
							for(int k = 0 ; k < listDBInpAdapterSubNode.getLength() ; k++){
								Node node = listDBInpAdapterSubNode.item(k);
								if(IConstant.XML_TAG.ValidateStatement.equalsIgnoreCase(node.getNodeName())){
									outputValidateStatement = node.getTextContent();
								}
							}
						}
					}
				}
				
			}
			} catch (Exception e){
				logger.error("Exception", e);
			}
		
		if(!StringUtils.isEmpty(inputValidateStatement)){
			inputTable = StringUtils.substringAfter(inputValidateStatement, "from").trim();
			if(inputTable.equals("")){
				inputTable = StringUtils.substringAfter(inputValidateStatement, "FROM").trim();
			}
		}
		
		if(!StringUtils.isEmpty(outputValidateStatement)){
			outputTable = StringUtils.substringAfter(outputValidateStatement, "from").trim();
			if(outputTable.equals("")){
				outputTable = StringUtils.substringAfter(outputValidateStatement, "FROM").trim();
			}
		}
		
		return new AdapterConfig(inputTable, outputTable, initStatement);
	}
	

	/**
	 * TODO: to load process config 
	 * @throws IOException 
	 */
	public static ArrayList<ProcessConfig> loadProcessConfig() throws IOException {
		loadProperties();
		ArrayList<ProcessConfig> listProcessConfig = new ArrayList<ProcessConfig>();
		try {
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			File file = new File(xmlUrl);
			Document doc = docBuilder.parse(file);

			Node ProcessNode = doc.getElementsByTagName(IConstant.XML_TAG.Process).item(0);
			NodeList listProcessSubNode = ProcessNode.getChildNodes();
			
			for (int i = 0 ; i < listProcessSubNode.getLength() ; i++){
				if(listProcessSubNode.item(i).getNodeType() == Node.ELEMENT_NODE){
					ProcessConfig processConfig = new ProcessConfig();
					processConfig.setName(listProcessSubNode.item(i).getNodeName());
					NodeList lstNode = listProcessSubNode.item(i).getChildNodes();
					for(int j = 0 ; j < lstNode.getLength() ; j++){
						if(IConstant.XML_TAG.Active.equalsIgnoreCase(lstNode.item(j).getNodeName())){
							processConfig.setIsActive(lstNode.item(j).getTextContent());
						}
					}
					listProcessConfig.add(processConfig);
				}
			}
			
			} catch (Exception e){
				logger.error("Exception", e);
			}
		
		return listProcessConfig;
	}
	
	
	public static void main(String args[]) throws IOException{
		try {
			loadProperties();
		} catch (IOException e) {
			logger.error("Exception", e);
		}

		DBConfigRC dbConfig = ReadXmlFile.loadDBConfigFromXML();
		logger.info(dbConfig.getHost());
	}

	public static ArrayList<PipelineConfig> loadPipelineConfig() throws IOException{
		loadProperties();
		ArrayList<PipelineConfig> listPipelineConfig = new ArrayList<PipelineConfig>();
		try {
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			File file = new File(xmlUrl);
			Document doc = docBuilder.parse(file);

			Node ProcessNode = doc.getElementsByTagName(IConstant.XML_TAG.PipelineList).item(0);
			NodeList listProcessSubNode = ProcessNode.getChildNodes();
			
			for (int i = 0 ; i < listProcessSubNode.getLength() ; i++){
				if(listProcessSubNode.item(i).getNodeType() == Node.ELEMENT_NODE){
					PipelineConfig pipelineConfig = new PipelineConfig();
					pipelineConfig.setPipelineName(listProcessSubNode.item(i).getNodeName());
					NodeList lstNode = listProcessSubNode.item(i).getChildNodes();
					for(int j = 0 ; j < lstNode.getLength() ; j++){
						if(IConstant.XML_TAG.Active.equalsIgnoreCase(lstNode.item(j).getNodeName())){
							pipelineConfig.setIsActive(lstNode.item(j).getTextContent());
						}
					}
					listPipelineConfig.add(pipelineConfig);
				}
			}
			
			} catch (Exception e){
				logger.error("Exception", e);
			}
		
		return listPipelineConfig;
	}
}
