package eonerateui.gui.menu.configuration;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import javax.swing.ButtonGroup;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import javax.swing.border.TitledBorder;
import javax.swing.JCheckBox;

import eonerateui.controller.xml.xmlParser;
import eonerateui.util.CodeConstants;
import eonerateui.util.IConstant;
import eonerateui.util.MessageConstants;
import eonerateui.util.ProgramConfig;

import javax.swing.UIManager;

@SuppressWarnings("serial")
public class RC_ConfigDialog extends JDialog {
	
	private final ButtonGroup buttonGroup = new ButtonGroup();
	private JTextField textAM;
	private JTextField textPM;
	private JTextField textBulk;
	private JRadioButton radioBackground;
	private JRadioButton radioDialog;
	private JComboBox comboTNS;
	private JComboBox comboAMh;
	private JComboBox comboAMm;
	private JComboBox comboPMh;
	private JComboBox comboPMm;
	private JTextField textPath;
	private JCheckBox checkAggregate;

	/**
	 * Create the dialog.
	 * @throws IOException 
	 */
	public RC_ConfigDialog() throws IOException {
		setFont(new Font("Dialog", Font.PLAIN, 12));
		setResizable(false);
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setModal(true);
		setModalityType(ModalityType.APPLICATION_MODAL);
		setAlwaysOnTop(false);
		setTitle("RC rating config"); //$NON-NLS-1$ //$NON-NLS-2$
		setBounds(100, 100, 428, 512);
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);

		JPanel pnlMode = new JPanel();
		pnlMode.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Rating mode setting", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		pnlMode.setBounds(10, 11, 404, 69);
		pnlMode.setLayout(null);
		getContentPane().add(pnlMode);
		
		radioBackground = new JRadioButton("Run in background mode"); //$NON-NLS-1$ //$NON-NLS-2$
		radioBackground.setFont(new Font("Tahoma", Font.PLAIN, 11));
		radioBackground.setBounds(36, 29, 180, 23);
		pnlMode.add(radioBackground);
		
		radioDialog = new JRadioButton("Run in dialog mode"); //$NON-NLS-1$ //$NON-NLS-2$
		radioDialog.setFont(new Font("Tahoma", Font.PLAIN, 11));
		radioDialog.setBounds(246, 29, 132, 23);
		pnlMode.add(radioDialog);
		
		buttonGroup.add(radioBackground);
		buttonGroup.add(radioDialog);			

		JPanel pnlAM = new JPanel();
		pnlAM.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Timmer setting - day time", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		pnlAM.setBounds(10, 81, 404, 99);
		pnlAM.setLayout(null);
		getContentPane().add(pnlAM);
		
		JLabel labelAMstart = new JLabel("Start time of day (hour/minute)"); //$NON-NLS-1$ //$NON-NLS-2$
		labelAMstart.setFont(new Font("Tahoma", Font.PLAIN, 11));
		labelAMstart.setBounds(22, 34, 191, 14);
		pnlAM.add(labelAMstart);
		
		JLabel labelAMrepeat = new JLabel("Repeat RC rating action after (minutes)"); //$NON-NLS-1$ //$NON-NLS-2$
		labelAMrepeat.setFont(new Font("Tahoma", Font.PLAIN, 11));
		labelAMrepeat.setBounds(22, 65, 249, 14);
		pnlAM.add(labelAMrepeat);
		
		comboAMh = new JComboBox();
		comboAMh.setModel(new DefaultComboBoxModel(new String[] {"6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17"}));
		comboAMh.setFont(new Font("Tahoma", Font.PLAIN, 11));
		comboAMh.setBounds(245, 28, 65, 20);
		pnlAM.add(comboAMh);
		
		comboAMm = new JComboBox();
		comboAMm.setModel(new DefaultComboBoxModel(new String[] {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "35", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"}));
		comboAMm.setFont(new Font("Tahoma", Font.PLAIN, 11));
		comboAMm.setBounds(320, 28, 66, 20);
		pnlAM.add(comboAMm);
		
		textAM = new JTextField();
		textAM.setFont(new Font("Tahoma", Font.PLAIN, 11));
		textAM.setHorizontalAlignment(SwingConstants.RIGHT);
		textAM.setBounds(281, 62, 105, 20);
		pnlAM.add(textAM);
		textAM.setColumns(10);
		textAM.addKeyListener(new KeyAdapter() {
			public void keyTyped(KeyEvent e) {
				char c = e.getKeyChar();
			    	if (!((c >= '0') && (c <= '9') || (c == KeyEvent.VK_BACK_SPACE) || (c == KeyEvent.VK_DELETE))) {
			    		getToolkit().beep();
			    		e.consume();
			    		c=' ';
			    	}
			}
		});
		
		JPanel pnlPM = new JPanel();
		pnlPM.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Timmer setting - night time", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		pnlPM.setBounds(10, 180, 404, 99);
		pnlPM.setLayout(null);
		getContentPane().add(pnlPM);
		
		JLabel labelPMstart = new JLabel("Start time of night (hour/minute)"); //$NON-NLS-1$ //$NON-NLS-2$
		labelPMstart.setFont(new Font("Tahoma", Font.PLAIN, 11));
		labelPMstart.setBounds(21, 34, 209, 14);
		pnlPM.add(labelPMstart);
		
		JLabel labelPMrepeat = new JLabel("Repeat RC rating action after (minutes)"); //$NON-NLS-1$ //$NON-NLS-2$
		labelPMrepeat.setFont(new Font("Tahoma", Font.PLAIN, 11));
		labelPMrepeat.setBounds(21, 65, 245, 14);
		pnlPM.add(labelPMrepeat);
		
		comboPMh = new JComboBox();
		comboPMh.setModel(new DefaultComboBoxModel(new String[] {"18", "19", "20", "21", "22", "23", "1", "2", "3", "4", "5"}));
		comboPMh.setFont(new Font("Tahoma", Font.PLAIN, 11));
		comboPMh.setBounds(245, 34, 65, 20);
		pnlPM.add(comboPMh);
		
		comboPMm = new JComboBox();
		comboPMm.setModel(new DefaultComboBoxModel(new String[] {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "35", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"}));
		comboPMm.setFont(new Font("Tahoma", Font.PLAIN, 11));
		comboPMm.setBounds(320, 34, 64, 20);
		pnlPM.add(comboPMm);
		
		textPM = new JTextField();
		textPM.setFont(new Font("Tahoma", Font.PLAIN, 11));
		textPM.setHorizontalAlignment(SwingConstants.RIGHT);
		textPM.setColumns(10);
		textPM.setBounds(281, 62, 105, 20);
		pnlPM.add(textPM);
		textPM.addKeyListener(new KeyAdapter() {
			public void keyTyped(KeyEvent e) {
				char c = e.getKeyChar();
			    	if (!((c >= '0') && (c <= '9') || (c == KeyEvent.VK_BACK_SPACE) || (c == KeyEvent.VK_DELETE))) {
			    		getToolkit().beep();
			    		e.consume();
			    		c=' ';
			    	}
			}
		});
		
		JPanel pnlProcess = new JPanel();
		pnlProcess.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Output process setting", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		pnlProcess.setBounds(10, 280, 404, 157);
		pnlProcess.setLayout(null);
		getContentPane().add(pnlProcess);
		
		JLabel labelBulk = new JLabel("Number of rated RC for bulk insert into"); //$NON-NLS-1$ //$NON-NLS-2$
		labelBulk.setFont(new Font("Tahoma", Font.PLAIN, 11));
		labelBulk.setBounds(23, 34, 238, 14);
		pnlProcess.add(labelBulk);
		
		JLabel labelTNS = new JLabel("TNS name for Oracle  Loader running"); //$NON-NLS-1$ //$NON-NLS-2$
		labelTNS.setFont(new Font("Tahoma", Font.PLAIN, 11));
		labelTNS.setBounds(23, 65, 238, 14);
		pnlProcess.add(labelTNS);
		
		textBulk = new JTextField();
		textBulk.setFont(new Font("Tahoma", Font.PLAIN, 11));
		textBulk.setHorizontalAlignment(SwingConstants.RIGHT);
		textBulk.setColumns(10);
		textBulk.setBounds(281, 31, 105, 20);
		pnlProcess.add(textBulk);
		textBulk.addKeyListener(new KeyAdapter() {
			public void keyTyped(KeyEvent e) {
				char c = e.getKeyChar();
			    	if (!((c >= '0') && (c <= '9') || (c == KeyEvent.VK_BACK_SPACE) || (c == KeyEvent.VK_DELETE))) {
			    		getToolkit().beep();
			    		e.consume();
			    		c=' ';
			    	}
			}
		});
		
		comboTNS = new JComboBox();
		comboTNS.setEditable(true);
		comboTNS.setFont(new Font("Tahoma", Font.PLAIN, 11));
		comboTNS.setBounds(281, 62, 105, 20);
		pnlProcess.add(comboTNS);
		
		JLabel lblPath = new JLabel("Folder of loader CSV"); //$NON-NLS-1$ //$NON-NLS-2$
		lblPath.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblPath.setBounds(23, 95, 127, 14);
		pnlProcess.add(lblPath);
		
		textPath = new JTextField();
		textPath.setFont(new Font("Tahoma", Font.PLAIN, 11));
		textPath.setHorizontalAlignment(SwingConstants.RIGHT);
		textPath.setText("");
		textPath.setBounds(177, 94, 154, 20);
		pnlProcess.add(textPath);
		textPath.setColumns(10);
		
		JButton btnFolder = new JButton("..."); 
		btnFolder.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				folderChooser();
			}
		});
		btnFolder.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnFolder.setBounds(335, 93, 51, 22);
		pnlProcess.add(btnFolder);
		
		checkAggregate = new JCheckBox("Always aggregate RC automatically after RC rating complete"); 
		checkAggregate.setFont(new Font("Tahoma", Font.PLAIN, 11));
		checkAggregate.setBounds(23, 116, 375, 23);
		pnlProcess.add(checkAggregate);
		
		//get config from XML
		getConfig();
		
		JButton buttonOK = new JButton("Save"); 
		buttonOK.setFont(new Font("Tahoma", Font.PLAIN, 11));
		buttonOK.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				xmlParser xml = null;
				try {
					xml = new xmlParser(ProgramConfig.getConfigFile());
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (radioBackground.isSelected())
					xml.setConfig("inBackground", Integer.toString(CodeConstants.RC_RATING.RUN_BACKGROUND));
				else
					xml.setConfig("inBackground", Integer.toString(CodeConstants.RC_RATING.RUN_MANUAL));
				
				xml.setConfig("amStart", Integer.toString((Integer.parseInt(comboAMh.getSelectedItem().toString())*60 + Integer.parseInt(comboAMm.getSelectedItem().toString()))));
				xml.setConfig("pmStart", Integer.toString((Integer.parseInt(comboPMh.getSelectedItem().toString())*60 + Integer.parseInt(comboPMm.getSelectedItem().toString()))) );

				xml.setConfig("amRepeat", textAM.getText().trim());
				xml.setConfig("pmRepeat", textPM.getText().trim());
				xml.setConfig("bulkInsert", textBulk.getText().trim());
				xml.setConfig("loadTNS", comboTNS.getSelectedItem().toString().trim());
				xml.setConfig("aggregate", (checkAggregate.isSelected()? "1": "0"));

				xml = null;
				
				JOptionPane.showMessageDialog(RC_ConfigDialog.this, MessageConstants.RC_RATING.RC_CONFIG_EFFECT);

				RC_ConfigDialog.this.dispose();
			}
		});
		buttonOK.setBounds(102, 448, 84, 24);
		getContentPane().add(buttonOK, BorderLayout.SOUTH);		
		
		JButton buttonCancel = new JButton("Close"); //$NON-NLS-1$ //$NON-NLS-2$
		buttonCancel.setFont(new Font("Tahoma", Font.PLAIN, 11));
		buttonCancel.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				RC_ConfigDialog.this.dispose();
			}
		});
		buttonCancel.setBounds(213, 448, 84, 24);
		getContentPane().add(buttonCancel);
		
	}
	
	private void getConfig() throws IOException {
		xmlParser xml = new xmlParser(ProgramConfig.getConfigFile());

		radioBackground.setSelected(Integer.parseInt(xml.getConfig("runMode", "inBackground")) == CodeConstants.RC_RATING.RUN_BACKGROUND);
		radioDialog.setSelected(!radioBackground.isSelected());
		textAM.setText(xml.getConfig("runMode", "amRepeat"));
		textPM.setText(xml.getConfig("runMode", "pmRepeat"));
		textBulk.setText(xml.getConfig("process", "bulkInsert"));
		textPath.setText(xml.getConfig("process", "dataPath"));
		
		int hour, min;
		int value = Integer.parseInt(xml.getConfig("runMode", "amStart"));
		hour = (int) Math.floor(value/60);
		min = value % 60;
		
		comboAMh.setSelectedItem(Integer.toString(hour));
		comboAMm.setSelectedItem(Integer.toString(min));
		
		value = Integer.parseInt(xml.getConfig("runMode", "pmStart"));
		hour = (int) Math.floor(value/60);
		min = value % 60;

		comboPMh.setSelectedItem(Integer.toString(hour));
		comboPMm.setSelectedItem(Integer.toString(min));
		
		setTNSvalue();
		
		comboTNS.setSelectedItem(xml.getConfig("process", "loadTNS"));
		checkAggregate.setSelected(xml.getConfig("process", "aggregate").equals(Integer.toString(CodeConstants.RC_RATING.AGGREGATE_WHEN_DONE)));
		
		xml = null;
	}
	
	private void setTNSvalue() {
		String oracleHome = System.getenv("ORACLE_HOME");
	    BufferedReader br = null;
		
	    try {
			if(oracleHome == null) {
				String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "program.conf";
				Properties props = new Properties();
				props.load(new FileInputStream(fileName));    
				oracleHome = props.getProperty("oracle_home", oracleHome);
			}
		
			String tnsFilename = oracleHome + File.separatorChar + 
								 "network" + File.separatorChar + 
			                     "admin" + File.separatorChar + 
			                     "tnsnames.ora";

	    	 String sCurrentLine;
	    	 br = new BufferedReader(new FileReader(tnsFilename));
	    	 while ((sCurrentLine = br.readLine()) != null) {
	    		 if (!(sCurrentLine.contains("(")||sCurrentLine.contains(")"))) {
	    			 sCurrentLine = sCurrentLine.replace("=", "").trim();
	    			 
	    			 if (sCurrentLine.length()>0) 
	    				 comboTNS.addItem(sCurrentLine);
	    		 }
	    	 }
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null)br.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}
	
	private void folderChooser() {
		JFileChooser chooser = new JFileChooser(textPath.getText());
	    chooser.setCurrentDirectory(new java.io.File("."));
	    chooser.setDialogTitle("Choose folder to store CSV file for loader");
	    chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
	    chooser.setAcceptAllFileFilterUsed(false);

	    if (chooser.showDialog(this, "Choose") == JFileChooser.APPROVE_OPTION) { 
	    	textPath.setText(chooser.getSelectedFile().getAbsolutePath());
	    }
	}
}
