/**
 * EciGwServicesServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package eci.services;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import eonerateui.util.IConstant;

@SuppressWarnings("serial")
public class EciGwServicesServiceLocator extends org.apache.axis.client.Service implements eci.services.EciGwServicesService {
	private static String eci_ws_url;
	public static void loadProperties() throws IOException {
		Properties props = new Properties();
		String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "program.conf";
		props.load(new FileInputStream(fileName));    
		eci_ws_url = props.getProperty("eci_ws_url", eci_ws_url);
	}
	
    public EciGwServicesServiceLocator() {
    }


    public EciGwServicesServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public EciGwServicesServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for EciGwServices
    private java.lang.String EciGwServices_address = eci_ws_url;

    public java.lang.String getEciGwServicesAddress() {
        return EciGwServices_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String EciGwServicesWSDDServiceName = "EciGwServices";

    public java.lang.String getEciGwServicesWSDDServiceName() {
        return EciGwServicesWSDDServiceName;
    }

    public void setEciGwServicesWSDDServiceName(java.lang.String name) {
        EciGwServicesWSDDServiceName = name;
    }

    public eci.services.EciGwServices getEciGwServices() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(EciGwServices_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getEciGwServices(endpoint);
    }

    public eci.services.EciGwServices getEciGwServices(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            eci.services.EciGwServicesSoapBindingStub _stub = new eci.services.EciGwServicesSoapBindingStub(portAddress, this);
            _stub.setPortName(getEciGwServicesWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setEciGwServicesEndpointAddress(java.lang.String address) {
        EciGwServices_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    @SuppressWarnings("rawtypes")
	public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (eci.services.EciGwServices.class.isAssignableFrom(serviceEndpointInterface)) {
                eci.services.EciGwServicesSoapBindingStub _stub = new eci.services.EciGwServicesSoapBindingStub(new java.net.URL(EciGwServices_address), this);
                _stub.setPortName(getEciGwServicesWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    @SuppressWarnings("rawtypes")
	public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("EciGwServices".equals(inputPortName)) {
            return getEciGwServices();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://services.eci", "EciGwServicesService");
    }

    @SuppressWarnings("rawtypes")
	private java.util.HashSet ports = null;

    @SuppressWarnings({ "rawtypes", "unchecked" })
	public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://services.eci", "EciGwServices"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("EciGwServices".equals(portName)) {
            setEciGwServicesEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
