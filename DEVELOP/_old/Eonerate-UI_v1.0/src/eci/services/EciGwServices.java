/**
 * EciGwServices.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package eci.services;

public interface EciGwServices extends java.rmi.Remote {
    public java.lang.String checkConnection() throws java.rmi.RemoteException;
    public int startECI() throws java.rmi.RemoteException;
    public int stopECI() throws java.rmi.RemoteException;
    public int checkStatus() throws java.rmi.RemoteException;
    public java.lang.String getLog() throws java.rmi.RemoteException;
}
