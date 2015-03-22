package eonerate.cdrintegration.support;

import java.util.concurrent.RejectedExecutionHandler;
import java.util.concurrent.ThreadPoolExecutor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author manucian86
 */
public class RejectedExecutionHandlerImpl implements RejectedExecutionHandler {

    private final Logger LOG = LoggerFactory.getLogger(RejectedExecutionHandlerImpl.class);

    @Override
    public void rejectedExecution(Runnable r, ThreadPoolExecutor tpe) {
        LOG.info(r.toString() + " is rejected");
    }

}
