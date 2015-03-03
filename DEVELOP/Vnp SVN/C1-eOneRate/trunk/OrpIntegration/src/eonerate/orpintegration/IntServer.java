package eonerate.orpintegration;

import java.io.IOException;
import java.net.BindException;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import eonerate.orpintegration.config.MainConfig;
import eonerate.orpintegration.config.XmlRepo;
import eonerate.orpintegration.support.FileUtil;
import eonerate.orpintegration.support.IntMonitor;
import eonerate.orpintegration.support.IntWorker;
import eonerate.orpintegration.support.RejectedExecutionHandlerImpl;

/**
 * Main class that can download files from an existing FTP server.
 */
public final class IntServer {

	private IntServer() {
	}

	public static String HostName, UserName, Password, Directory;

	private static ServerSocket serverSocket;

	private static void checkIfRunning() {
		try {
			//Bind to localhost adapter with a zero connection queue 
			serverSocket = new ServerSocket(MainConfig.currentInstance.getInstancePort(), 0, InetAddress.getByAddress(new byte[] { 127, 0, 0, 1 }));
		} catch (BindException e) {
			System.err.println("Port: " + MainConfig.currentInstance.getInstancePort() + " is busy => An Instance is already running.");
			System.exit(1);
		} catch (IOException e) {
			System.err.println("Cannot create socket on PORT: " + MainConfig.currentInstance.getInstancePort());
			e.printStackTrace();
			System.exit(2);
		}
	}

	public static void main(String[] args) throws Exception {

		MainConfig.currentInstance = XmlRepo.readMainConfig();

		checkIfRunning();

		if (MainConfig.currentInstance == null) {
			return;
		}

		//		if (!FileUtil.createFolderIfNotExist(MainConfig.currentInstance.getDestFolderPath())) {
		//			System.err.println("Cannot create DESTINATION FOLDER: " + MainConfig.currentInstance.getDestFolderPath());
		//			return;
		//		}

		//		if (args.length < 4) {
		//			System.err.println("### HostName, UserName, Password, Directory is required");
		//			return;
		//		}

		HostName = MainConfig.currentInstance.getDestHostName(); // args[0];
		UserName = MainConfig.currentInstance.getDestUserName(); // args[1];
		Password = MainConfig.currentInstance.getDestPassword(); // args[2];
		Directory = MainConfig.currentInstance.getDestDirectory(); // Constant.INPUT_DIRECTORY.replace("_", Constant.INPUT_OS_FILE_SEPARATOR); // args[3].replace("_", Constant.INPUT_OS_FILE_SEPARATOR);

		//		List<String> slus = FileUtil.getAllChildFolders(HostName, UserName, Password, Directory);

		//		String[] slus = MainConfig.currentInstance.getSlus().split(";");

		//			Main main = new Main();
		//			main.addRouteBuilder(new IntServerRouteBuilder());
		//			main.enableHangupSupport();
		//			main.run();

		//RejectedExecutionHandler implementation
		RejectedExecutionHandlerImpl rejectionHandler = new RejectedExecutionHandlerImpl();

		//Get the ThreadFactory implementation to use
		ThreadFactory threadFactory = Executors.defaultThreadFactory();

		//creating the ThreadPoolExecutor
		ThreadPoolExecutor executorPool = new ThreadPoolExecutor(
				MainConfig.currentInstance.getCorePoolSize(),
				MainConfig.currentInstance.getMaximumPoolSize(),
				10,
				TimeUnit.SECONDS,
				new LinkedBlockingQueue<Runnable>(),
				threadFactory,
				rejectionHandler);

		//start the monitoring thread
		IntMonitor monitor = new IntMonitor(executorPool, 15);

		Thread monitorThread = new Thread(monitor);

		monitorThread.start();

		//		for (String sluName : slus) {
		//			// submit work to the thread pool
		//			//			for (int i = 0; i < 1; i++) {
		executorPool.execute(new IntWorker("ORP Integration Worker"));
		//			//			}
		//		}

		//        Thread.sleep(15000);
		//        //shut down the pool
		//        executorPool.shutdown();
		//        //shut down the monitor thread
		//        Thread.sleep(5000);
		//        monitor.shutdown();

	}

}
