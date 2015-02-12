package eonerate.cdrintegration.support;

import eonerate.cdrintegration.IntServerRouteBuilder;
import org.apache.camel.main.Main;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author manucian86
 */
public class IntWorker implements Runnable {

    private final Logger LOG = LoggerFactory.getLogger(IntWorker.class);

    public IntWorker(String s) {
    }

    @Override
    public void run() {
        try {

            Main main = new Main();
            main.addRouteBuilder(new IntServerRouteBuilder());
            main.enableHangupSupport();
            main.run();

        } catch (Exception ex) {

            LOG.error("WHEN: Init Camel main; ERROR: " + ex.toString(), ex);

        }
    }

}
