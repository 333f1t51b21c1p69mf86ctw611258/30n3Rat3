package eonerate.orpintegration.support;

import org.apache.camel.main.Main;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import eonerate.orpintegration.MyFtpServerRouteBuilder;

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
			main.addRouteBuilder(new MyFtpServerRouteBuilder());
			main.enableHangupSupport();
			main.run();

		} catch (Exception ex) {

			LOG.error("WHEN: Init Camel main; ERROR: " + ex.toString(), ex);

		}
	}
}
