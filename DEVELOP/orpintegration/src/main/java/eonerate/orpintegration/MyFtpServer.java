/**
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package eonerate.orpintegration;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import eonerate.orpintegration.support.IntMonitor;
import eonerate.orpintegration.support.IntWorker;
import eonerate.orpintegration.support.RejectedExecutionHandlerImpl;

/**
 * Main class that can download files from an existing FTP server.
 */
public final class MyFtpServer {

	private MyFtpServer() {
	}

	public static void main(String[] args) throws Exception {
		//        Main main = new Main();
		//        main.addRouteBuilder(new MyFtpServerRouteBuilder());
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

		// Submit work to the thread pool
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