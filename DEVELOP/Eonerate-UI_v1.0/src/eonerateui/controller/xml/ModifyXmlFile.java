package eonerateui.controller.xml;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import eonerateui.gui.menu.configuration.AdapterConfig;
import eonerateui.gui.menu.configuration.PipelineConfig;
import eonerateui.gui.menu.configuration.ProcessConfig;
import eonerateui.util.IConstant;


public class ModifyXmlFile {
	private static Logger logger=Logger.getLogger("ModifyXmlFile");
	public static String xmlUrl = "";
	public static Properties props = new Properties();
	
	public static void loadProperties() throws IOException {
		String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "program.conf";
		props.load(new FileInputStream(fileName));    
		xmlUrl = props.getProperty("config_url",xmlUrl);
	}
	
	private static final int SUCCESS = 0;
	private static final int EXCEPTION = -2;
	
	
	/**
	 * TODO:  to update database configuration in xml file
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
	
	public static int updateDatabaseConfig(String username, String password, String host, String port, String serviceName) {
		try {
			loadProperties();
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
											node.setTextContent("jdbc:oracle:thin:@//" + host + ":" + port + "/" + serviceName);
										}
										if(IConstant.XML_TAG.username.equalsIgnoreCase(node.getNodeName())){
											node.setTextContent(username);
										}
										if(IConstant.XML_TAG.password.equalsIgnoreCase(node.getNodeName())){
											node.setTextContent(password);
										}
										
									}
								}
							}
						}
					}
				}
				
			}
			
			// write the content into xml file
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource source = new DOMSource(doc);
			StreamResult result = new StreamResult(new File(xmlUrl));
			transformer.transform(source, result);
			logger.info("Update database config successfully");
			
		   }catch (Exception e) {
			   logger.error("Exception", e);
			return EXCEPTION;
		   }
		return SUCCESS;
	}
		

	
	/**
	 * TODO:  to update pipeline configuration in OpenRate framework
	 * 
	 * @param isActive
	 *
	 * @author Son.Pham.Hong
	 * @date 07 Nov 2013
	 */
	
	public static int updateELCPipeline(String isActive){
		try {
		loadProperties();
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
						ActiveNode.setTextContent(isActive);
					}
				}
			}
		}
		
		// write the content into xml file
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		DOMSource source = new DOMSource(doc);
		StreamResult result = new StreamResult(new File(xmlUrl));
		transformer.transform(source, result);
		
		} catch (Exception e){
			logger.error("Exception", e);
			return EXCEPTION;
		}
		logger.info("-- Update updateELCPipeline successfull! --");
		return SUCCESS;
	}


	/**
	 * TODO:  to update input adapter configuration in OpenRate framework
	 * 
	 * @param isActive
	 *
	 * @author Son.Pham.Hong
	 * @date 11 Nov 2013
	 *//*
	
	public static int saveInputAdapterConfigToXml(AdapterConfig inputAdapterConfig) {
		try {
			loadProperties();
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			File file = new File(xmlUrl);
			Document doc = docBuilder.parse(file);

			Node eOneRatePipelineNode = doc.getElementsByTagName(IConstant.XML_TAG.eOneRatePipeline).item(1);
			NodeList listELCPipelineSubNode = eOneRatePipelineNode.getChildNodes();
			for (int i = 0 ; i < listELCPipelineSubNode.getLength() ; i++){
				Node ELCPipelineSubNode = listELCPipelineSubNode.item(i);
				
				
				 * update input adapter
				 
				if (IConstant.XML_TAG.InputAdapter.equalsIgnoreCase(ELCPipelineSubNode.getNodeName())){
					NodeList listInputAdapterSubNode = ELCPipelineSubNode.getChildNodes();
					for (int j = 0 ; j < listInputAdapterSubNode.getLength() ; j++){
						Node DBInpAdapterNode = listInputAdapterSubNode.item(j);
						if(IConstant.XML_TAG.DBInpAdapter.equalsIgnoreCase(DBInpAdapterNode.getNodeName())){
							NodeList listDBInpAdapterSubNode = DBInpAdapterNode.getChildNodes();
							for(int k = 0 ; k < listDBInpAdapterSubNode.getLength() ; k++){
								Node node = listDBInpAdapterSubNode.item(k);
								updateInputAdapterNodeContent(node, inputAdapterConfig);
							}
						}
					}
				}
			}
			
			// write the content into xml file
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource source = new DOMSource(doc);
			StreamResult result = new StreamResult(new File(xmlUrl));
			transformer.transform(source, result);
			
			} catch (Exception e){
				logger.error("Exception", e);
				return EXCEPTION;
			}
		
			logger.info("-- Update input adapter successfull! --");
			return SUCCESS;
		
	}
	*/

/*
	*//**
	 * TODO:  to update input adapter node content 
	 *  
	 * @param node, inputAdapaterConfig
	 *
	 * @author Son.Pham.Hong
	 * @date 13 Nov 2013
	 *//*
	
	private static void updateInputAdapterNodeContent(Node node, AdapterConfig inputAdapterConfig) {
		//update ValidateStatement
		if(IConstant.XML_TAG.ValidateStatement.equalsIgnoreCase(node.getNodeName())){
			node.setTextContent("select count(*) from " + inputAdapterConfig.getTableName());
		}
		
		//update RecordCountStatement
		if(IConstant.XML_TAG.RecordCountStatement.equalsIgnoreCase(node.getNodeName())){
			node.setTextContent("select count(*) from " + inputAdapterConfig.getTableName() + " where RERATE_FLAG = 0" + getReplaceConditionValue(inputAdapterConfig.getNewCondition()));
		}
		
		//update RecordCountStatement
		if(IConstant.XML_TAG.InitStatement.equalsIgnoreCase(node.getNodeName())){
			node.setTextContent("update " + inputAdapterConfig.getTableName() + " set RERATE_FLAG = 1 where RERATE_FLAG = 0" + getReplaceConditionValue(inputAdapterConfig.getNewCondition()));
		}
		
		//update RecordSelectStatement
		if(IConstant.XML_TAG.RecordSelectStatement.equalsIgnoreCase(node.getNodeName())){
			String selectValue = StringUtils.substringBeforeLast(node.getTextContent(), "from");
			String newValue = selectValue + "from " + inputAdapterConfig.getTableName() + " where RERATE_FLAG = 1" + getReplaceConditionValue(inputAdapterConfig.getNewCondition()); 
			node.setTextContent(newValue);
		}
		
		//update CommitStatement
		if(IConstant.XML_TAG.CommitStatement.equalsIgnoreCase(node.getNodeName())){
			node.setTextContent("update " + inputAdapterConfig.getTableName() + " set RERATE_FLAG = 2 where RERATE_FLAG = 1" + getReplaceConditionValue(inputAdapterConfig.getNewCondition()));
		}
		
		//update RollbackStatement
		if(IConstant.XML_TAG.RollbackStatement.equalsIgnoreCase(node.getNodeName())){
			node.setTextContent("update " + inputAdapterConfig.getTableName() + " set RERATE_FLAG = 2 where RERATE_FLAG = 1" + getReplaceConditionValue(inputAdapterConfig.getNewCondition()));
		}
		
	}*/


	public static String getReplaceConditionValue(String conditionValue){
		if(StringUtils.isEmpty(conditionValue)){
			return "";
		}else{
			return " AND " + conditionValue;
		}
	}


	/**
	 * TODO:  to update process configuration in OpenRate Framework
	 * 
	 * @param listProcess
	 *
	 * @author Son.Pham.Hong
	 * @date 13 Nov 2013
	 */
	
	public static int updateProcessConfig(ArrayList<ProcessConfig> listProcessConfig) {
		try {
			loadProperties();
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			File file = new File(xmlUrl);
			Document doc = docBuilder.parse(file);
			Node ProcessNode = doc.getElementsByTagName(IConstant.XML_TAG.Process).item(0);
			NodeList listProcessSubNode = ProcessNode.getChildNodes();
			
			for (int i = 0 ; i < listProcessSubNode.getLength() ; i++){
				if(listProcessSubNode.item(i).getNodeType() == Node.ELEMENT_NODE){
					// update value for node content
					updateProcessNodeValue(listProcessSubNode.item(i), listProcessConfig);
				}
			}
			// write the content into xml file
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource source = new DOMSource(doc);
			StreamResult result = new StreamResult(new File(xmlUrl));
			transformer.transform(source, result);
			
		} catch (Exception e){
			logger.error("Exception", e);
				return EXCEPTION;		
		}
		logger.info("-- Update process config successfull! --");
			return SUCCESS;
	}

	public static int updatePipelineConfig(ArrayList<PipelineConfig> listPipeline) {
		try {
			loadProperties();
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			File file = new File(xmlUrl);
			Document doc = docBuilder.parse(file);
			Node ProcessNode = doc.getElementsByTagName(IConstant.XML_TAG.PipelineList).item(0);
			NodeList listProcessSubNode = ProcessNode.getChildNodes();
			
			for (int i = 0 ; i < listProcessSubNode.getLength() ; i++){
				if(listProcessSubNode.item(i).getNodeType() == Node.ELEMENT_NODE){
					// update value for node content
					updatePipelineNodeValue(listProcessSubNode.item(i), listPipeline);
				}
			}
			// write the content into xml file
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource source = new DOMSource(doc);
			StreamResult result = new StreamResult(new File(xmlUrl));
			transformer.transform(source, result);
			
		} catch (Exception e){
			logger.error("Exception", e);
				return EXCEPTION;		
		}
		logger.info("-- Update process config successfull! --");
			return SUCCESS;
	}
	
	
	/**
	 * TODO:  to set value for Process Sub Node
	 * 
	 * @param Node
	 * @param listProcessConfig
	 *
	 * @author Son.Pham.Hong
	 * @date 13 Nov 2013
	 */
	
	private static void updateProcessNodeValue(Node item, ArrayList<ProcessConfig> listProcessConfig) {
		for(ProcessConfig processConfig : listProcessConfig){
			if(item.getNodeName().equalsIgnoreCase(processConfig.getName())){
				NodeList listSubNode = item.getChildNodes();
				for(int i = 0 ; i < listSubNode.getLength() ; i++){
					if(IConstant.XML_TAG.Active.equalsIgnoreCase(listSubNode.item(i).getNodeName())){
						listSubNode.item(i).setTextContent(processConfig.getIsActive().toString());
					}
				}
			}
		}
	}

	/**
	 * TODO:  to set value for Pipeline Sub Node
	 * 
	 * @param Node
	 * @param listPipelineConfig
	 *
	 * @author Son.Pham.Hong
	 * @date 13 Nov 2013
	 */
	
	private static void updatePipelineNodeValue(Node item, ArrayList<PipelineConfig> listPipelineConfig) {
		for(PipelineConfig pipelineConfig : listPipelineConfig){
			if(item.getNodeName().equalsIgnoreCase(pipelineConfig.getPipelineName())){
				NodeList listSubNode = item.getChildNodes();
				for(int i = 0 ; i < listSubNode.getLength() ; i++){
					if(IConstant.XML_TAG.Active.equalsIgnoreCase(listSubNode.item(i).getNodeName())){
						listSubNode.item(i).setTextContent(pipelineConfig.getIsActive().toString());
					}
				}
			}
		}
	}


	/**
	 * TODO: to set value for adapter configuration
	 * 
	 * @param oldInputTable
	 * @param oldOutputTable
	 * @param adapterConfig
	 * @return
	 * 
	 * @author Son.Pham.Hong
	 * @date 26 Feb 2014
	 * 
	 */
	public static int updateAdapaterConfig(String oldInputTable, String oldOutputTable, AdapterConfig adapterConfig) {
		try {
			loadProperties();
			File xmlFile = new File(xmlUrl);
			relaceStringInXml(xmlFile, oldInputTable, adapterConfig.getInputTable());
			relaceStringInXml(xmlFile, oldOutputTable, adapterConfig.getOutputTable());
			logger.info("-- Update updateAdapaterConfig successfull! --");
			return SUCCESS;
	}catch (Exception e) {
			logger.error("Exception: ", e);
			return EXCEPTION;
	}
	}
		
	public static void relaceStringInXml(File xmlFile, String inputString, String replaceString) throws IOException{
			String newline = System.getProperty("line.separator");
			BufferedReader br = new BufferedReader(new FileReader(xmlFile));
			String line = null;
			StringBuffer sb = new StringBuffer("");
			while((line = br.readLine())!= null)
			{
			    if(line.indexOf(inputString) != -1)
			    {
			        line = line.replaceAll(inputString,replaceString);
			    }         
			    sb.append(line).append(newline);               
			}
			br.close();

			BufferedWriter bw = new BufferedWriter(new FileWriter(xmlFile));
			bw.write(sb.toString());
			bw.close();
		}
	
}
