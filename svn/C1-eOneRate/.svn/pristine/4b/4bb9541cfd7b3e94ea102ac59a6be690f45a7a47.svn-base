package eonerate.orpintegration.support;

import java.util.concurrent.ThreadPoolExecutor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author manucian86
 */
public class IntMonitor implements Runnable {

	private final Logger LOG = LoggerFactory.getLogger(IntMonitor.class);

	private final ThreadPoolExecutor executor;

	private final int seconds;

	private boolean run = true;

	public IntMonitor(ThreadPoolExecutor executor, int delay) {
		this.executor = executor;
		this.seconds = delay;
	}

	public void shutdown() {
		this.run = false;
	}

	@Override
	public void run() {
		while (run) {
			LOG.info(String.format("[Thread Monitor]"
					+ "\n\t\t\t\t\t\t\t\t\t - PoolSize: %d"
					+ "\n\t\t\t\t\t\t\t\t\t - CorePoolSize: %d"
					+ "\n\t\t\t\t\t\t\t\t\t - Active: %d"
					+ "\n\t\t\t\t\t\t\t\t\t - Completed: %d"
					+ "\n\t\t\t\t\t\t\t\t\t - Task: %d"
					+ "\n\t\t\t\t\t\t\t\t\t - isShutdown: %s"
					+ "\n\t\t\t\t\t\t\t\t\t - isTerminated: %s",
					this.executor.getPoolSize(),
					this.executor.getCorePoolSize(),
					this.executor.getActiveCount(),
					this.executor.getCompletedTaskCount(),
					this.executor.getTaskCount(),
					this.executor.isShutdown(),
					this.executor.isTerminated()));

			try {

				Thread.sleep(seconds * 1000);

			} catch (InterruptedException e) {

				LOG.error("WHEN: Sleep", e);

			}
		}
	}

}
