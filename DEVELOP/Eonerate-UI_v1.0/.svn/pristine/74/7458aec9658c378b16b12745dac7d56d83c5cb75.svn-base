package eonerateui.gui.menu.configuration;

import java.awt.Cursor;
import java.awt.EventQueue;

import javax.swing.JDialog;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.border.LineBorder;

import java.awt.Color;

import javax.swing.JTextArea;
import javax.swing.JScrollPane;

import java.awt.Font;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

import javax.swing.JButton;

import org.apache.log4j.Logger;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.toedter.components.JSpinField;

import eonerateui.controller.xml.xmlParser;
import eonerateui.db.pool.DBconnect;
import eonerateui.util.MessageConstants;
import eonerateui.util.ProgramConfig;


public class AggregateConfig extends JDialog {
	private static Logger logger=Logger.getLogger("AggregateConfig");
	private JSpinField spinPipeline;
	private JSpinField spinTime;
	private JTextArea textArea;
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					AggregateConfig dialog = new AggregateConfig();
					dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
					dialog.setVisible(true);
				} catch (Exception e) {
					logger.error("Exception", e);
				}
			}
		});
	}

	/**
	 * Create the dialog.
	 * @throws IOException 
	 */
	public AggregateConfig() throws IOException {
		setTitle("Dispatching and Aggregation config");
		setModalityType(ModalityType.APPLICATION_MODAL);
		setResizable(false);
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 420, 300);
		setLocationRelativeTo(null);;
		getContentPane().setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBorder(new LineBorder(Color.LIGHT_GRAY));
		panel.setBounds(10, 11, 390, 86);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Numbers of pipeline for dispatching and aggregation");
		lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 10));
		lblNewLabel.setBounds(10, 20, 293, 14);
		panel.add(lblNewLabel);
		
		spinPipeline = new JSpinField();
		spinPipeline.setMinimum(1);
		spinPipeline.setMaximum(10);
		spinPipeline.setBounds(320, 17, 58, 20);
		panel.add(spinPipeline);
		
		JLabel lblTimeForPipeline = new JLabel("Time  of dispatching and aggregation refesh (second)");
		lblTimeForPipeline.setFont(new Font("Tahoma", Font.PLAIN, 10));
		lblTimeForPipeline.setBounds(10, 49, 293, 14);
		panel.add(lblTimeForPipeline);
		
		spinTime = new JSpinField();
		spinTime.setBounds(320, 48, 58, 20);
		spinPipeline.setMinimum(1);
		panel.add(spinTime);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(10, 108, 390, 118);
		scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		getContentPane().add(scrollPane);
		
		textArea = new JTextArea();
		textArea.setForeground(new Color(0, 128, 128));
		textArea.setWrapStyleWord(true);
		textArea.setLineWrap(true);
		scrollPane.setViewportView(textArea);
		
		JButton btnNewButton = new JButton("OK");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					saveConfig();
				} catch (IOException e1) {
					logger.error("IOException", e1);
				} catch (SQLException e1) {
					logger.error("SQLException", e1);
				}
			}
		});
		btnNewButton.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnNewButton.setBounds(250, 237, 70, 23);
		getContentPane().add(btnNewButton);
		
		JButton btnCancel = new JButton("Close");
		btnCancel.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnCancel.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				AggregateConfig.this.dispose();
			}
		});
		btnCancel.setBounds(330, 237, 70, 23);
		getContentPane().add(btnCancel);
		
		loadConfig();
		
	}
	
	private void loadConfig() throws IOException {
		xmlParser xml = new xmlParser(ProgramConfig.getConfigFile());
		
		spinPipeline.setValue(Integer.parseInt(xml.getConfig("pipeline", "totalPipeline")));
		spinTime.setValue(Integer.parseInt(xml.getConfig("timeRefresh", "second")));
		
		xml = null;
	}

	private void saveConfig() throws IOException, SQLException {
		AggregateConfig.this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		xmlParser xml = new xmlParser(ProgramConfig.getConfigFile());
		
		xml.setConfig("totalPipeline", Integer.toString(spinPipeline.getValue()));
		xml.setConfig("second", Integer.toString(spinTime.getValue()));
		
		textArea.setText(MessageConstants.AGGREGATE_DISPATCH.AGGREGATE_CONFIGURED);
		
		DBconnect db = new DBconnect();
		Statement st = db.createStatement();
		String schema = db.getDbconfig().getDb_data_schema();
		String owner = schema.substring(0, schema.length()-1).toUpperCase();
		
		for (int i=1; i<= spinPipeline.getValue(); i++ ) {
			String tableName = xml.getConfig("pipeline", "pipelineTable" + Integer.toString(i));
			String viewName  = xml.getConfig("pipeline", "pipelineView" + Integer.toString(i));
			
			String sql = "SELECT 1 FROM all_tables WHERE owner = '" + owner + "' AND upper(table_name) = upper('" + tableName + "')";
			ResultSet rs = db.Select(sql, true, st);
			
			//không có bảng này -> tạo
			if (!rs.next()) {
				sql = "CREATE TABLE " + schema + tableName + " AS SELECT * FROM " + schema + "rated_cdr";
				db.Update(sql);
				
				sql = "CREATE INDEX idx_temp_" + Integer.toString(i) + " ON " + schema + tableName +"(a_number, cdr_type, payment_item_id, cdr_start_time)";
				db.Update(sql);
			}
			
			sql = "CREATE OR REPLACE VIEW " + db.getDbconfig().getDb_data_schema() + viewName + " AS " + 
				  "   SELECT /*+ PARALLEL(FIRST_TEMP_RATED_CDR, 4) */" +
			      "     count(1) total_cdr, " +
				  "		a_number," +
			      "		to_date(to_char (cdr_start_time, 'MMyyyy'), 'MMyyyy') bill_month," +
			      "     cdr_type," +
			      "		payment_item_id," +
			      "		sum(total_usage) to_tal_usage," +
			      "		sum(service_fee) service_free," +
			      "		sum(charge_fee) charge_fee," +
			      "		sum(offer_cost) offer_cost," +
			      "		sum(offer_free_block) offer_free_block," +
			      "		sum(internal_cost) internal_cost," +
			      "		sum(internal_free_block) internal_free_block" +
			      "   FROM " + schema + tableName +
			      "	  GROUP BY a_number, cdr_type, payment_item_id, to_date(to_char(cdr_start_time, 'MMyyyy'), 'MMyyyy')";
						
			db.Update(sql);
		}
		
		db.commit();
		db.close();

		textArea.append(MessageConstants.AGGREGATE_DISPATCH.ALL_VIEW_CONFIGURED);
		textArea.append("\n");
		textArea.append("Important notice: ");
		textArea.append(MessageConstants.AGGREGATE_DISPATCH.CONFIG_NOTIFICATION);

		xml = null;

		AggregateConfig.this.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
	}
}
