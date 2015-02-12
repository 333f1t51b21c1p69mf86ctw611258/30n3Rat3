/**
 * 
 */
/**
 * @author ??ng H� Vinh
 *
 */
package eonerateui.controller.xml;

import java.io.File;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;


public class xmlParser {
	private static Logger logger=Logger.getLogger("xmlParser");
	private static Document doc;
	private String configFile;
	
	public xmlParser(String _configFile) {
		try {
			this.configFile = _configFile;
			doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new File(configFile));
		} catch (SAXException e) {
			logger.error("SAXException", e);
		} catch (IOException e) {
			logger.error("IOException", e);
		} catch (ParserConfigurationException e) {
			logger.error("ParserConfigurationException", e);
		}
	}

	public String getConfig(String tagName, String configValue) {
		String value = "";
		try {
			doc.getDocumentElement().normalize();
			NodeList nodes = doc.getElementsByTagName(tagName);
	
			for (int i = 0; i < nodes.getLength(); i++) {
				Node node = nodes.item(i);
	
				if (node.getNodeType() == Node.ELEMENT_NODE) {
					Element element = (Element) node;
					value = getValue(configValue, element);
					break;
				}
			}
		} catch (Exception ex) {
			logger.error("Exception", ex);
		}
		
		return value;
	}
	
	private static String getValue(String tag, Element element) {
		NodeList nodes = element.getElementsByTagName(tag).item(0).getChildNodes();
		Node node = (Node) nodes.item(0);
		
		return node.getNodeValue();
	}
	
	public void setConfig(String tagName, String nodeValue) {
		try {
			Element element = doc.getDocumentElement();  
			element.getElementsByTagName(tagName).item(0).setTextContent(nodeValue);  
			
			// write the content into xml file
			Transformer transformer = TransformerFactory.newInstance().newTransformer();
			DOMSource source = new DOMSource(doc);
			StreamResult result = new StreamResult(new File(configFile));
			transformer.transform(source, result);
			
		} catch (Exception ex) {
			logger.error("Exception", ex);
		}
		
	}
	
	public void createConfig(String tagParent, String tagName, String configValue) {
		try {
			doc.getDocumentElement().normalize();
			NodeList nodes = doc.getElementsByTagName(tagParent);
	
			for (int i = 0; i < nodes.getLength(); i++) {
				Node node = nodes.item(i);
	
				if ((node.getNodeType() == Node.ELEMENT_NODE) && (node.getNodeName()==tagParent)) {
					Element element = (Element) node;
					Element eTagName = doc.createElement(tagName);
					eTagName.appendChild(doc.createTextNode(configValue));
					element.appendChild(eTagName);
					
					// write the content into xml file
					Transformer transformer = TransformerFactory.newInstance().newTransformer();
					DOMSource source = new DOMSource(doc);
					StreamResult result = new StreamResult(new File(configFile));
					transformer.transform(source, result);
					
					break;
				}
			}
		} catch (Exception ex) {
			logger.error("Exception", ex);
		}
	}
}
