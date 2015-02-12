package eonerateui.gui.menu.configuration;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;

import eonerateui.controller.main.MainProcessor;
import eonerateui.util.CodeConstants;
import eonerateui.util.MessageConstants;
import java.awt.Font;

@SuppressWarnings("serial")
public class DBConfigDialog extends JDialog {
	private JTextField usernameTextField;
	private JTextField hostTextField;
	private JTextField servicesNameTextField;
	private JTextField passwordTextField;
	private JTextField portTextField;
	private JTextArea resultTextArea;
	private String newLine = "\n";

	/**
	 * Create the dialog.
	 */
	public DBConfigDialog() {
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setModalityType(ModalityType.APPLICATION_MODAL);
		setResizable(false);
	/*	
		try {
			UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
		} catch(Exception e){
			e.printStackTrace();
		}*/
		DBConfigDialog.setDefaultLookAndFeelDecorated(true);
		
		setTitle("Database Configuration");
		setBounds(100, 100, 559, 402);
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		
		JPanel inputPanel = new JPanel();
		inputPanel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Database connection", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		inputPanel.setBounds(12, 11, 531, 150);
		getContentPane().add(inputPanel);
		inputPanel.setLayout(null);
		
		JLabel lblNewLabel_1 = new JLabel("Username:");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblNewLabel_1.setBounds(39, 29, 71, 16);
		inputPanel.add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("Host:");
		lblNewLabel_2.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblNewLabel_2.setBounds(62, 69, 44, 16);
		inputPanel.add(lblNewLabel_2);
		
		JLabel lblServicesName = new JLabel("Services Name:");
		lblServicesName.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblServicesName.setBounds(17, 109, 92, 16);
		inputPanel.add(lblServicesName);
		
		usernameTextField = new JTextField();
		usernameTextField.setFont(new Font("Tahoma", Font.PLAIN, 11));
		usernameTextField.setBounds(128, 26, 152, 27);
		inputPanel.add(usernameTextField);
		usernameTextField.setColumns(10);
		
		hostTextField = new JTextField();
		hostTextField.setFont(new Font("Tahoma", Font.PLAIN, 11));
		hostTextField.setColumns(10);
		hostTextField.setBounds(128, 66, 152, 27);
		inputPanel.add(hostTextField);
		
		servicesNameTextField = new JTextField();
		servicesNameTextField.setFont(new Font("Tahoma", Font.PLAIN, 11));
		servicesNameTextField.setColumns(10);
		servicesNameTextField.setBounds(127, 106, 389, 27);
		inputPanel.add(servicesNameTextField);
		
		JLabel lblPassword = new JLabel("Password:");
		lblPassword.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblPassword.setBounds(292, 33, 65, 16);
		inputPanel.add(lblPassword);
		
		JLabel lblPort = new JLabel("Port:");
		lblPort.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblPort.setBounds(318, 69, 36, 16);
		inputPanel.add(lblPort);
		
		passwordTextField = new JTextField();
		passwordTextField.setFont(new Font("Tahoma", Font.PLAIN, 11));
		passwordTextField.setColumns(10);
		passwordTextField.setBounds(360, 26, 156, 27);
		inputPanel.add(passwordTextField);
		
		portTextField = new JTextField();
		portTextField.setFont(new Font("Tahoma", Font.PLAIN, 11));
		portTextField.setColumns(10);
		portTextField.setBounds(360, 66, 155, 27);
		inputPanel.add(portTextField);
		
		JPanel resultPanel = new JPanel();
		resultPanel.setBorder(new TitledBorder(null, "Result", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		resultPanel.setBounds(12, 172, 531, 150);
		getContentPane().add(resultPanel);
		resultPanel.setLayout(null);
		
		resultTextArea = new JTextArea();
		resultTextArea.setWrapStyleWord(true);
		resultTextArea.setLineWrap(true);
		resultTextArea.setBounds(12, 25, 507, 112);
		resultPanel.add(resultTextArea);
		
		JButton btnSubmit = new JButton("Submit");
		btnSubmit.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnSubmit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				updateDatabaseConfig();
			}
		});
		btnSubmit.setBounds(163, 333, 97, 29);
		getContentPane().add(btnSubmit);
		
		JButton buttonClose = new JButton("Close");
		buttonClose.setFont(new Font("Tahoma", Font.PLAIN, 11));
		buttonClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				DBConfigDialog.this.dispose();
			}
		});
		buttonClose.setBounds(327, 333, 97, 29);
		getContentPane().add(buttonClose);
		
		loadConfigFromXml();
		
	}
	
	protected void updateDatabaseConfig() {
		int result = MainProcessor.updateDatabaseConfig(usernameTextField.getText(), passwordTextField.getText(), hostTextField.getText(), portTextField.getText(), servicesNameTextField.getText());
		if(result == CodeConstants.COMMON.SUCCESS){
			resultTextArea.setText("");
			resultTextArea.setText(newLine);
			resultTextArea.append(MessageConstants.DB_CONFIGURATION.SUCCESS);
			resultTextArea.setForeground(Color.BLUE);
		}else{
			resultTextArea.setText("");
			resultTextArea.setText(newLine);
			resultTextArea.append(MessageConstants.DB_CONFIGURATION.FAIL);
			resultTextArea.setForeground(Color.RED);
		}
	}
	
	public void loadConfigFromXml(){
		/*
		 * Load db config from xml file
		 */
		DBConfigRC dbconfig = MainProcessor.loadDBConfigFromXML();
		usernameTextField.setText(dbconfig.getUsername());
		passwordTextField.setText(dbconfig.getPassword());
		hostTextField.setText(dbconfig.getHost());
		servicesNameTextField.setText(dbconfig.getServiceName());
		portTextField.setText(dbconfig.getPort());
		resultTextArea.setForeground(Color.black);
		resultTextArea.setText("");
	}
	
	public void init(){
		loadConfigFromXml();
		
	}
}
