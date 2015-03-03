package eonerate.orpintegration;

import org.apache.camel.main.Main;

/**
 * Main class that can upload files to an existing FTP server.
 */
public final class IntClient {

    private IntClient() {
    }

    public static void main(String[] args) throws Exception {
        Main main = new Main();
        main.addRouteBuilder(new IntClientRouteBuilder());
        main.enableHangupSupport();
        main.run();
    }

}
