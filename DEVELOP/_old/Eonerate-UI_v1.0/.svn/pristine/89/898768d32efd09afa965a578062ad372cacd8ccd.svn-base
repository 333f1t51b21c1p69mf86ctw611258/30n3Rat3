package eonerateui.gui.menu.system;

import java.awt.Color;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.swing.DefaultComboBoxModel;
import javax.swing.ImageIcon;
import javax.swing.InputMap;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPasswordField;
import javax.swing.KeyStroke;

import org.apache.log4j.Logger;

import eonerateui.controller.main.MainProcessor;
import eonerateui.entity.user.UserAccount;
import eonerateui.gui.main.MainApplicationUI;

@SuppressWarnings("serial")
public class LoginDialog extends JDialog {
	private static Logger logger=Logger.getLogger("LoginDialog");
	private JPasswordField passwordTxtField;
	private JLabel lblResult;
	private Boolean isLogin = false;
	private int role;
	private JComboBox usernamecomboBox;
	

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			LoginDialog dialog = new LoginDialog();
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}

	/**
	 * Create the dialog.
	 */
	public LoginDialog() {
		setModalityType(ModalityType.APPLICATION_MODAL);
		setBounds(100, 100, 453, 309);
		getContentPane().setLayout(null);
		setLocationRelativeTo(null);
//		try {
//			UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
//		} catch(Exception e){
//			logger.error("Exception", e);
//		}
		LoginDialog.setDefaultLookAndFeelDecorated(true);
		setResizable(false);
		JLabel label = new JLabel("");
		label.setIcon(new ImageIcon("./images/login_logo.PNG"));
		label.setBounds(0, 0, 447, 74);
		getContentPane().add(label);
		
		JLabel label_1 = new JLabel("Enter your username and password :");
		label_1.setFont(new Font("Tahoma", Font.BOLD, 12));
		label_1.setBounds(29, 87, 311, 27);
		getContentPane().add(label_1);
		
		JLabel label_2 = new JLabel("Name");
		label_2.setFont(new Font("Tahoma", Font.PLAIN, 12));
		label_2.setBounds(62, 130, 58, 16);
		getContentPane().add(label_2);
		
		JLabel label_3 = new JLabel("Password");
		label_3.setFont(new Font("Tahoma", Font.PLAIN, 12));
		label_3.setBounds(44, 175, 86, 16);
		getContentPane().add(label_3);
		
		setPasswordTxtField(new JPasswordField());
		getPasswordTxtField().setBounds(140, 172, 287, 23);
		getContentPane().add(getPasswordTxtField());
		
		JButton button = new JButton("OK");
		button.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					login();
				} catch (SQLException e1) {
					logger.error("SQLException", e1);
				} catch (IOException e1) {
					logger.error("IOException", e1);
				}
			}
		});
		button.setBounds(243, 246, 86, 23);
		getContentPane().add(button);
		
		lblResult = new JLabel("Result");
		lblResult.setBounds(29, 212, 401, 23);
		lblResult.setVisible(false);
		getContentPane().add(lblResult);
		
		JButton btnCancel = new JButton("Cancel");
		btnCancel.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MainApplicationUI.loginForm.dispose();
			}
		});
		btnCancel.setBounds(341, 246, 86, 23);
		getContentPane().add(btnCancel);
		
		/*
		 * add Enter default for OK button
		 */
		getRootPane().setDefaultButton(button);
		
		usernamecomboBox = new JComboBox();
		usernamecomboBox.setEditable(true);
		usernamecomboBox.setBounds(140, 127, 287, 23);
		getContentPane().add(usernamecomboBox);
		InputMap im = button.getInputMap();
	    im.put(KeyStroke.getKeyStroke("ENTER"), "pressed");
	    im.put(KeyStroke.getKeyStroke("released ENTER"), "released");
	    
	    /*
	     * Load the username from log 
	     */
	    List<String> listSavedUsername = MainProcessor.loadUsernamesFromLog();
	    usernamecomboBox.setModel(new DefaultComboBoxModel(listSavedUsername.toArray()));
	}

	@SuppressWarnings("deprecation")
	protected void login() throws SQLException, IOException {
	     setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		 String username = usernamecomboBox.getSelectedItem().toString();
		 String password = getPasswordTxtField().getText();
		 //String loginResult = MainProcessor.login(username, password);
		 UserAccount userAccount = MainProcessor.login(username, password);
		 int role = userAccount.getRole();
	     setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
	     
		if(role < 0){
			lblResult.setVisible(true);
			lblResult.setForeground(Color.RED);
			lblResult.setFont(new Font("Arial", Font.BOLD, 12));
			lblResult.setText("Exception! Please contact to the admin");
			this.setIsLogin(false);
		}else if(role == 0){
			lblResult.setVisible(true);
			lblResult.setForeground(Color.RED);
			lblResult.setFont(new Font("Arial", Font.BOLD, 12));
			lblResult.setText("Login unsucessfully !\nInvalid username or password");
			this.setIsLogin(false);
		}
		else{
			logger.warn("Login Succesfully!");
			this.setIsLogin(true);
			this.setRole(userAccount.getRole());
			MainProcessor.saveUsernameToLog(username);
			MainApplicationUI.username = username;
			MainApplicationUI.checkLoginStatus();
		}
	}

	public Boolean getIsLogin() {
		return isLogin;
	}

	public void setIsLogin(Boolean isLogin) {
		this.isLogin = isLogin;
	}


	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public JPasswordField getPasswordTxtField() {
		return passwordTxtField;
	}

	public void setPasswordTxtField(JPasswordField passwordTxtField) {
		this.passwordTxtField = passwordTxtField;
	}
}
