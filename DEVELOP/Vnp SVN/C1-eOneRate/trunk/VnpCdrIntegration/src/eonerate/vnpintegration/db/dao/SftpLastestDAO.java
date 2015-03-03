package eonerate.vnpintegration.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import eonerate.vnpintegration.db.DatabaseRepo;
import eonerate.vnpintegration.entity.SftpLastest;

public class SftpLastestDAO {

	private static final Logger LOG = LoggerFactory.getLogger(SftpLastestDAO.class);

	public static List<SftpLastest> getBySlu(String slu) {

		List<SftpLastest> result = new ArrayList<SftpLastest>();

		Connection dbConnection = null;
		Statement statement = null;

		String selectTableSQL = "SELECT SLU, LASTEST_CDR_TIME FROM VNP_COMMON.ORP_SFTP_LASTEST WHERE SLU = '" + slu + "'";

		try {

			dbConnection = DatabaseRepo.getDBConnection();
			statement = dbConnection.createStatement();

			//			System.out.println(selectTableSQL);

			// execute select SQL stetement
			ResultSet rs = statement.executeQuery(selectTableSQL);

			while (rs.next()) {

				SftpLastest sftpLastest = new SftpLastest();
				sftpLastest.slu = rs.getString("SLU");
				//				sftpLastest.dateFolder = rs.getString("DATE_FOLDER");
				sftpLastest.lastestCdrTime = rs.getLong("LASTEST_CDR_TIME");

				result.add(sftpLastest);

			}

		} catch (SQLException e) {

			LOG.error("WHEN: Get SftpLastest list by Slu", e);

		} finally {

			DatabaseRepo.closeStatement(statement);
			DatabaseRepo.closeConnection(dbConnection);

		}

		return result;

	}

	public static boolean create(SftpLastest sftpLastest) {

		boolean result = false;

		Connection connection = null;
		CallableStatement callableStatement = null;

		String callScript = "{call VNP_COMMON.ORP_DML_TABLE.INS_SFTP_LASTEST(?,?)}";

		try {

			connection = DatabaseRepo.getDBConnection();
			callableStatement = connection.prepareCall(callScript);

			callableStatement.setString(1, sftpLastest.slu);
			//			callableStatement.setString(2, sftpLastest.dateFolder);
			callableStatement.setLong(2, sftpLastest.lastestCdrTime);

			callableStatement.executeUpdate();

			result = true;

		} catch (SQLException e) {

			LOG.error("WHEN: Insert SftpLastest", e);

		} finally {

			DatabaseRepo.closeStatement(callableStatement);

			DatabaseRepo.closeConnection(connection);

		}

		return result;

	}

	public static boolean update(SftpLastest sftpLastest) {

		boolean result = false;

		Connection connection = null;
		CallableStatement callableStatement = null;

		String callScript = "{call VNP_COMMON.ORP_DML_TABLE.UPD_SFTP_LASTEST(?,?)}";

		try {

			connection = DatabaseRepo.getDBConnection();
			callableStatement = connection.prepareCall(callScript);

			callableStatement.setString(1, sftpLastest.slu);
			//			callableStatement.setString(2, sftpLastest.dateFolder);
			callableStatement.setLong(2, sftpLastest.lastestCdrTime);

			callableStatement.executeUpdate();

			result = true;

		} catch (SQLException e) {

			LOG.error("WHEN: Update SftpLastest", e);

		} finally {

			DatabaseRepo.closeStatement(callableStatement);

			DatabaseRepo.closeConnection(connection);

		}

		return result;

	}

	public static boolean merge(SftpLastest sftpLastest) {

		boolean result = false;

		Connection connection = null;
		CallableStatement callableStatement = null;

		String callScript = "{call VNP_COMMON.ORP_DML_TABLE.MERGE_SFTP_LASTEST(?,?)}";

		try {

			connection = DatabaseRepo.getDBConnection();
			callableStatement = connection.prepareCall(callScript);

			callableStatement.setString(1, sftpLastest.slu);
			//			callableStatement.setString(2, sftpLastest.dateFolder);
			callableStatement.setLong(2, sftpLastest.lastestCdrTime);

			callableStatement.executeUpdate();

			result = true;

		} catch (SQLException e) {

			LOG.error("WHEN: Merge SftpLastest", e);

		} finally {

			DatabaseRepo.closeStatement(callableStatement);

			DatabaseRepo.closeConnection(connection);

		}

		return result;

	}

	public static boolean merge(SftpLastest sftpLastest, Connection connection) {

		boolean result = false;

		//		Connection connection = null;
		CallableStatement callableStatement = null;

		String callScript = "{call VNP_COMMON.ORP_DML_TABLE.MERGE_SFTP_LASTEST(?,?)}";

		try {

			//			connection = DatabaseRepo.getDBConnection();
			callableStatement = connection.prepareCall(callScript);

			callableStatement.setString(1, sftpLastest.slu);
			//			callableStatement.setString(2, sftpLastest.dateFolder);
			callableStatement.setLong(2, sftpLastest.lastestCdrTime);

			callableStatement.executeUpdate();

			result = true;

		} catch (SQLException e) {

			LOG.error("WHEN: Merge SftpLastest", e);

		} finally {

			DatabaseRepo.closeStatement(callableStatement);

			//			DatabaseRepo.closeConnection(connection);

		}

		return result;

	}

}
