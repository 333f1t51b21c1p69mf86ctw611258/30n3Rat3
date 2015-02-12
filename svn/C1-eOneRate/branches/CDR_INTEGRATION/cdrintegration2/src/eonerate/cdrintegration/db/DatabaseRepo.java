package eonerate.cdrintegration.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import eonerate.cdrintegration.config.MainConfig;
import eonerate.cdrintegration.support.Constant;

public class DatabaseRepo {

	private static final Logger LOG = LoggerFactory.getLogger(DatabaseRepo.class);

	public static Connection getDBConnection() {

		Connection dbConnection = null;

		try {
			Class.forName(Constant.DB_DRIVER);
		} catch (ClassNotFoundException e) {
			LOG.error("JDBC driver not found", e);
		}

		int retryCount = 0;

		do {
			try {

				dbConnection = DriverManager.getConnection(
						MainConfig.currentInstance.getDbConnection(),
						MainConfig.currentInstance.getDbUserName(),
						MainConfig.currentInstance.getDbPassword());

				return dbConnection;

			} catch (SQLException e) {

				retryCount++;
				LOG.error("WHEN: Get Database Connection => Retry count: " + retryCount, e);

				try {
					Thread.sleep(3000);
				} catch (InterruptedException e1) {
					e1.printStackTrace();
				}

			}
		} while (retryCount < 4);

		return dbConnection;

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
