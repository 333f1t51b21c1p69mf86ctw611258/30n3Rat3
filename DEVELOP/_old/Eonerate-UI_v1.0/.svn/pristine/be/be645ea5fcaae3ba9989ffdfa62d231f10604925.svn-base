package eonerateui.db.pool;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import oracle.jdbc.pool.OracleConnectionCacheManager;
import oracle.jdbc.pool.OracleDataSource;

@SuppressWarnings("static-access")
public class DBPool {
	public static DBConfig dbc = new DBConfig();
	public final static String CACHE_NAME = "MYCACHE";
	public static OracleDataSource ods = null;

	static {

		try {
			ods = new OracleDataSource();			
			ods.setURL(dbc.getDb_url());
			ods.setDriverType(dbc.getDb_driver());
			ods.setUser(dbc.getDb_user());
			ods.setPassword(dbc.getDb_pass());
			
			// caching parms
			ods.setConnectionCachingEnabled(true);
			ods.setConnectionCacheName(CACHE_NAME);
			Properties cacheProps = new Properties();
			cacheProps.setProperty("ValidateConnection", dbc.ValidateConnection + "");

			ods.setConnectionCacheProperties(cacheProps);
			


		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * private constructor for static class
	 */
	public DBPool() {
	}

	public static Connection getConnection() throws SQLException {
		if (ods == null) {
			ods = new OracleDataSource();			
			ods.setURL(dbc.getDb_url());
			ods.setDriverType(dbc.getDb_driver());
			ods.setUser(dbc.getDb_user());
			ods.setPassword(dbc.getDb_pass());
					
			// caching parms
			ods.setConnectionCachingEnabled(true);
			ods.setConnectionCacheName(CACHE_NAME);
			Properties cacheProps = new Properties();
			cacheProps.setProperty("ValidateConnection", dbc.ValidateConnection + "");
			ods.setConnectionCacheProperties(cacheProps);
		}
		return ods.getConnection();
	}

	public static Connection getConnection(String env) throws SQLException {
		System.out.println("Request connection for " + env);
		if (ods == null) {
			throw new SQLException("OracleDataSource is null.");
		}
		return ods.getConnection();
	}

	public static void closePooledConnections() throws SQLException {
		if (ods != null) {
			ods.close();
		}
	}

	public static void listCacheInfos() throws SQLException {
		OracleConnectionCacheManager occm = OracleConnectionCacheManager
				.getConnectionCacheManagerInstance();
		System.out.println(occm.getNumberOfAvailableConnections(CACHE_NAME)
				+ " connections are available in cache " + CACHE_NAME);
		System.out.println(occm.getNumberOfActiveConnections(CACHE_NAME)
				+ " connections are active");

	}

	public static void releaseConnection(Connection conn,
			PreparedStatement preStmt) {
		try {
			if (conn != null) {
				conn.close();
			} else {
				// //logger.error("conn is null.");
			}
			if (preStmt != null) {
				preStmt.close();
			}
		} catch (SQLException e) {
			// logger.error(e.getMessage());
		}
	}

	public static void releaseConnection(Connection conn,
			PreparedStatement preStmt, ResultSet rs) {
		releaseConnection(conn, preStmt);
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			// logger.error(e.getMessage());
		}
	}

	public static void releaseConnection(Connection conn,
			CallableStatement preStmt) {
		try {
			if (conn != null) {
				conn.close();
			} else {
				// logger.info("conn is null.");
			}
			if (preStmt != null) {
				preStmt.close();
			}
		} catch (SQLException e) {
			// logger.error(e.getMessage());
		}
	}

	public static void releaseConnection(Connection conn,
			CallableStatement preStmt, ResultSet rs) {
		releaseConnection(conn, preStmt);
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
		}
	}

	public static void releaseConnection(Connection conn,
			PreparedStatement preStmt, Statement stmt, ResultSet rs) {
		releaseConnection(conn, preStmt, rs);
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException e) {
		}
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
		}
	}

}
