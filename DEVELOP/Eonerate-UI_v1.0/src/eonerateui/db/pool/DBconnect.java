/**
 * 
 */
/**
 * @author Dang Ha Vinh
 *
 */
package eonerateui.db.pool;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBconnect {
	
	private Connection conn 	= null;
	private Statement stmUpdate = null;
	private int batchSize = 0;
	private int count = 0;
	private DBConfig dbconfig = new DBConfig();
	
	public DBconnect() {		
        try{
        	/*
        	 * init database config
        	 */
        	
            // Create a connection to the database 
            conn = DBPool.getConnection();
            conn.setAutoCommit(false);
           
        }catch(Exception e){
            e.printStackTrace();
        }
	}

	public void setAutoCommit() throws SQLException {
		conn.setAutoCommit(true);
	}

	public void setBulk(int _batchSize) throws SQLException {
		batchSize = _batchSize;
		count = 0;
		
		if (stmUpdate!=null) stmUpdate.close();
		stmUpdate = conn.createStatement();
	}
	
	public void close() throws SQLException {
		if (conn!=null) conn.close();
		if (stmUpdate!=null) stmUpdate.close();
	}

	public void commitBulk() throws SQLException {
		if (stmUpdate!=null) {
			if (batchSize !=0 ) {
				//update remaining records of bulk insert/update
				stmUpdate.executeBatch();
				stmUpdate.clearBatch();
				stmUpdate.close();
			}
		}

		//reset init value for future action
		conn.commit();
		count=0;
		batchSize=0;
	}

	public void rollback() throws SQLException {
		if (conn != null) conn.rollback();
		if (stmUpdate != null) stmUpdate.close();
	}
	
	public void commit() throws SQLException {
		if (conn != null) conn.commit();
	}

	public void Update(String sql) throws SQLException {
        try {
			if (batchSize==0) {
				if (stmUpdate==null) 
					stmUpdate = conn.createStatement();
						
				stmUpdate.execute(sql);
			}
			else {
				stmUpdate.addBatch(sql);
				
				if(++count % batchSize == 0) {
					stmUpdate.executeBatch();
					stmUpdate.clearBatch();
				}
			}	       			        	       	
        } catch (SQLException e) {
        	e.printStackTrace();
        	if (conn!=null) conn.rollback();
        }
	}
	
	public ResultSet Select(String sql, boolean isReadOnly, Statement st) throws SQLException {
		return st.executeQuery(sql);
	}
	
	public Statement createStatement() throws SQLException {
		return conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	}

	public DBConfig getDbconfig() {
		return dbconfig;
	}

	public void setDbconfig(DBConfig dbconfig) {
		this.dbconfig = dbconfig;
	}

	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}
	
}
