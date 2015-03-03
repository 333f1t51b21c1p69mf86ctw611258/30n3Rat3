package eonerate.vnpintegration.db;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import eonerate.vnpintegration.config.MainConfig;

public class DatabaseRepo {

	private static final Logger LOG = LoggerFactory.getLogger(DatabaseRepo.class);

	//	public static Connection getDBConnection() {
	//
	//		Connection dbConnection = null;
	//
	//		try {
	//			Class.forName(Constant.DB_DRIVER);
	//		} catch (ClassNotFoundException e) {
	//			LOG.error("JDBC driver not found", e);
	//		}
	//
	//		long retryCount = 0;
	//		boolean trueFlag = true;
	//
	//		while (trueFlag) {
	//			try {
	//
	//				dbConnection = DriverManager.getConnection(
	//						MainConfig.currentInstance.getDbConnection(),
	//						MainConfig.currentInstance.getDbUserName(),
	//						MainConfig.currentInstance.getDbPassword());
	//
	//				return dbConnection;
	//
	//			} catch (SQLException e) {
	//
	//				if (retryCount < Long.MAX_VALUE) {
	//					retryCount++;
	//					LOG.error("WHEN: Get Database Connection => Retry count: " + retryCount, e);
	//				} else {
	//					retryCount = 0;
	//					LOG.error("WHEN: Get Database Connection => Old RetryCount = " + Long.MAX_VALUE + " (MAX) => Retry count: " + retryCount, e);
	//				}
	//
	//				try {
	//					Thread.sleep(5000);
	//				} catch (InterruptedException e1) {
	//					e1.printStackTrace();
	//				}
	//
	//			}
	//		}
	//
	//		return null;
	//
	//	}

	private static HikariDataSource ds = null;

	public static void initDataSource() {
		HikariConfig config = new HikariConfig();
		//		config.setDataSourceClassName("oracle.jdbc.pool.OracleDataSource");
		config.setJdbcUrl(MainConfig.currentInstance.getDbConnection());
		config.setUsername(MainConfig.currentInstance.getDbUserName());
		config.setPassword(MainConfig.currentInstance.getDbPassword());
		config.addDataSourceProperty("cachePrepStmts", "true");
		config.addDataSourceProperty("prepStmtCacheSize", "250");
		config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
		config.addDataSourceProperty("useServerPrepStmts", "true");

		ds = new HikariDataSource(config);
	}

	public static Connection getDBConnection() {

		Connection dbConnection = null;

		long retryCount = 0;
		boolean trueFlag = true;

		while (trueFlag) {
			try {

				dbConnection = ds.getConnection();

				return dbConnection;

			} catch (SQLException e) {

				if (retryCount < Long.MAX_VALUE) {
					retryCount++;
					LOG.error("WHEN: Get Database Connection => Retry count: " + retryCount, e);
				} else {
					retryCount = 0;
					LOG.error("WHEN: Get Database Connection => Old RetryCount = " + Long.MAX_VALUE + " (MAX) => Retry count: " + retryCount, e);
				}

				try {
					Thread.sleep(5000);
				} catch (InterruptedException e1) {
					e1.printStackTrace();
				}

			}
		}

		return null;

	}

	public static void closeConnection(Connection connection) {

		if (connection != null) {

			try {

				connection.close();

			} catch (SQLException e) {

				LOG.error("WHEN: Close Database Connection", e);

			}

		}

	}

	public static void closeStatement(Statement statement) {

		if (statement != null) {

			try {
				statement.close();
			} catch (SQLException e) {

				LOG.error("WHEN: Close Statement", e);

			}

		}

	}

}
