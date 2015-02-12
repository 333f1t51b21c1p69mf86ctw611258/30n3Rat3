package eci.services;

public class EciGwServicesProxy implements eci.services.EciGwServices {
  private String _endpoint = null;
  private eci.services.EciGwServices eciGwServices = null;
  
  public EciGwServicesProxy() {
    _initEciGwServicesProxy();
  }
  
  public EciGwServicesProxy(String endpoint) {
    _endpoint = endpoint;
    _initEciGwServicesProxy();
  }
  
  private void _initEciGwServicesProxy() {
    try {
      eciGwServices = (new eci.services.EciGwServicesServiceLocator()).getEciGwServices();
      if (eciGwServices != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)eciGwServices)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)eciGwServices)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (eciGwServices != null)
      ((javax.xml.rpc.Stub)eciGwServices)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public eci.services.EciGwServices getEciGwServices() {
    if (eciGwServices == null)
      _initEciGwServicesProxy();
    return eciGwServices;
  }
  
  public java.lang.String checkConnection() throws java.rmi.RemoteException{
    if (eciGwServices == null)
      _initEciGwServicesProxy();
    return eciGwServices.checkConnection();
  }
  
  public int startECI() throws java.rmi.RemoteException{
    if (eciGwServices == null)
      _initEciGwServicesProxy();
    return eciGwServices.startECI();
  }
  
  public int stopECI() throws java.rmi.RemoteException{
    if (eciGwServices == null)
      _initEciGwServicesProxy();
    return eciGwServices.stopECI();
  }
  
  public int checkStatus() throws java.rmi.RemoteException{
    if (eciGwServices == null)
      _initEciGwServicesProxy();
    return eciGwServices.checkStatus();
  }
  
  public java.lang.String getLog() throws java.rmi.RemoteException{
    if (eciGwServices == null)
      _initEciGwServicesProxy();
    return eciGwServices.getLog();
  }
  
  
}