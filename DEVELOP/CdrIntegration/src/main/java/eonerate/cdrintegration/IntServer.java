package eonerate.cdrintegration;

import eonerate.cdrintegration.support.IntMonitor;
import eonerate.cdrintegration.support.IntWorker;
import eonerate.cdrintegration.support.RejectedExecutionHandlerImpl;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * Main class that can download files from an existing FTP server.
 */
public final class IntServer {

	private IntServer() {
	}

	public static void main(String[] args) throws Exception {
		//        Main main = new Main();
		//        main.addRouteBuilder(new IntServerRouteBuilder());
		//        main.enableHangupSupport();
		//        main.run();

		//RejectedExecutionHandler implementation
		RejectedExecutionHandlerImpl rejectionHandler = new RejectedExecutionHandlerImpl();

		//Get the ThreadFactory implementation to use
		ThreadFactory threadFactory = Executors.defaultThreadFactory();

		//creating the ThreadPoolExecutor
		ThreadPoolExecutor executorPool = new ThreadPoolExecutor(2, 4, 10, TimeUnit.SECONDS, new ArrayBlockingQueue<Runnable>(2), threadFactory, rejectionHandler);

		//start the monitoring thread
		IntMonitor monitor = new IntMonitor(executorPool, 3);

		Thread monitorThread = new Thread(monitor);

		monitorThread.start();
		// submit work to the thread pool
		for (int i = 0; i < 1; i++) {
			executorPool.execute(new IntWorker("cmd" + i));
		}

		//        Thread.sleep(15000);
		//        //shut down the pool
		//        executorPool.shutdown();
		//        //shut down the monitor thread
		//        Thread.sleep(5000);
		//        monitor.shutdown();
	}

}
