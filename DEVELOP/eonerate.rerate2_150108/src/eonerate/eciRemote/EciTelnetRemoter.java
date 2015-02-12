package eonerate.eciRemote;

import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EciTelnetRemoter {

    public static void remote(ILogger logEci, String ip, int port, String command) throws IOException {

        Socket pingSocket = null;
        PrintWriter out = null;
        BufferedReader in = null;

        try {
            
            pingSocket = new Socket(ip, port);
            pingSocket.setSoTimeout(5000);

            out = new PrintWriter(pingSocket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(pingSocket.getInputStream()));

            //        out.println("Framework:Shutdown=true");
            logEci.info(String.format("Create Telnet ECI command [IP: %s; Port: %d; Command: %s]", ip, port, command));

            out.println(command);

            String text;

            try {
                while ((text = in.readLine()) != null) {
                    logEci.info("TelnetResult > " + text);
                }
            } catch (SocketTimeoutException ste) {
                
            }

        } catch (IOException e) {

            logEci.error("WHEN: Create Telnet ECI command; ERROR: " + e.toString(), e);

        } finally {
            if (out != null) {
                out.close();
            }

            if (in != null) {
                in.close();
            }

            if (pingSocket != null) {
                pingSocket.close();
            }
        }

    }

    public static void main(String[] args) {

        ILogger logEci = LogUtil.getLogUtil().getLogger("ECI");

        try {
            remote(logEci, "localhost", 8668, "Framework:Shutdown=true");
        } catch (IOException ex) {
            Logger.getLogger(EciTelnetRemoter.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
