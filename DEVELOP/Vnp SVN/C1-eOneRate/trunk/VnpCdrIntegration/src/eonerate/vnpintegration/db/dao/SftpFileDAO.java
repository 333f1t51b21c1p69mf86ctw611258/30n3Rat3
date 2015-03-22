package eonerate.vnpintegration.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import eonerate.vnpintegration.db.DatabaseRepo;
import eonerate.vnpintegration.entity.SftpFile;
import eonerate.vnpintegration.entity.SftpLastest;

public class SftpFileDAO {

	private static final Logger LOG = LoggerFactory.getLogger(SftpFileDAO.class);

	public static boolean create(SftpFile sftpFile) {

		boolean result = false;

		Connection connection = null;
		CallableStatement callableStatement = null;

		String callScript = "{call ? := VNP_COMMON.ORP_DML_TABLE.INS_SFTP_FILE(?,?,?,?,?,?,?)}";

		try {

			connection = DatabaseRepo.getDBConnection();
			callableStatement = connection.prepareCall(callScript);

			callableStatement.setString(2, sftpFile.sftpFile);
			callableStatement.setString(3, sftpFile.slu);
			callableStatement.setInt(4, sftpFile.seq);
			callableStatement.setLong(5, sftpFile.fileSize);
			callableStatement.setInt(6, sftpFile.status);
			callableStatement.setInt(7, sftpFile.retry);
			callableStatement.setString(8, sftpFile.note);

			callableStatement.registerOutParameter(1, java.sql.Types.NUMERIC);

			callableStatement.executeUpdate();

			int sqlResult = callableStatement.getInt(1);

			if (sqlResult == 1) {
				result = true;
			} else if (sqlResult == 99) {
				LOG.warn("WHEN: Insert SftpFile from SLU Folder: " + sftpFile.slu + " => Existed SftpFile on DB: " + sftpFile.sftpFile);
			}

		} catch (SQLException e) {

			LOG.error("WHEN: Insert SftpFile", e);

		} finally {

			DatabaseRepo.closeStatement(callableStatement);

			DatabaseRepo.closeConnection(connection);

		}

		return result;

	}

	public static boolean update(SftpFile sftpFile) {

		boolean result = false;

		Connection connection = null;
		CallableStatement callableStatement = null;

		String callScript = "{call VNP_COMMON.ORP_DML_TABLE.UPD_SFTP_FILE(?,?,?,?,?,?,?)}";

		try {

			connection = DatabaseRepo.getDBConnection();
			callableStatement = connection.prepareCall(callScript);

			callableStatement.setString(1, sftpFile.sftpFile);
			callableStatement.setString(2, sftpFile.slu);
			callableStatement.setInt(3, sftpFile.seq);
			callableStatement.setLong(4, sftpFile.fileSize);
			callableStatement.setInt(5, sftpFile.status);
			callableStatement.setInt(6, sftpFile.retry);
			callableStatement.setString(7, sftpFile.note);

			callableStatement.executeUpdate();

			result = true;

		} catch (SQLException e) {

			LOG.error("WHEN: Update SftpFile", e);

		} finally {

			DatabaseRepo.closeStatement(callableStatement);

			DatabaseRepo.closeConnection(connection);

		}

		return result;

	}

	public static boolean updateWithLastest(SftpFile sftpFile, SftpLastest sftpLastest) {

		boolean result = false;

		Connection connection = null;
		CallableStatement callableStatement = null;

		String callScript = "{call VNP_COMMON.ORP_DML_TABLE.UPD_SFTP_FILE(?,?,?,?,?,?,?)}";

		try {

			connection = DatabaseRepo.getDBConnection();
			connection.setAutoCommit(false);

			callableStatement = connection.prepareCall(callScript);

			callableStatement.setString(1, sftpFile.sftpFile);
			callableStatement.setString(2, sftpFile.slu);
			callableStatement.setInt(3, sftpFile.seq);
			callableStatement.setLong(4, sftpFile.fileSize);
			callableStatement.setInt(5, sftpFile.status);
			callableStatement.setInt(6, sftpFile.retry);
			callableStatement.setString(7, sftpFile.note);

			callableStatement.executeUpdate();

			if (SftpLastestDAO.merge(sftpLastest, connection)) {
				connection.commit();

				result = true;
			} else {
				connection.rollback();
			}

		} catch (SQLException e) {

			LOG.error("WHEN: Update SftpFile", e);

		} finally {

			DatabaseRepo.closeStatement(callableStatement);

			DatabaseRepo.closeConnection(connection);

		}

		return result;

	}

}
