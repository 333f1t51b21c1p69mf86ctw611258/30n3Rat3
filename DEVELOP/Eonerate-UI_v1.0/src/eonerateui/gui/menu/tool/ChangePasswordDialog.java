package eonerateui.gui.menu.tool;

import java.awt.Color;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;

import org.apache.commons.lang3.StringUtils;

import eonerateui.db.UserAccountDAO;
import eonerateui.entity.user.UserAccount;
import eonerateui.gui.main.MainApplicationUI;
import eonerateui.util.SecurityUtils;

public class ChangePasswordDialog extends JDialog {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private JLabel usernameLbl;
	private JPasswordField currentPassField;
	private JPasswordField newPassField;
	private JPasswordField verifyPassField;
	private JLabel resultLabel;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			ChangePasswordDialog dialog = new ChangePasswordDialog();
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Create the dialog.
	 */
	public ChangePasswordDialog() {
		setResizable(false);
		setTitle("Change Password");
		setBounds(100, 100, 429, 241);
		setModalityType(ModalityType.APPLICATION_MODAL);
		getContentPane().setLayout(null);
		setLocationRelativeTo(null);
		
//		try {
//			UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
//		} catch(Exception e){
//			e.printStackTrace();
//		}
		ChangePasswordDialog.setDefaultLookAndFeelDecorated(true);
		
		
		JPanel panel = new JPanel();
		panel.setBounds(0, 0, 411, 204);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblUsername = new JLabel("Username :");
		lblUsername.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblUsername.setBounds(79, 27, 73, 16);
		panel.add(lblUsername);
		
		usernameLbl = new JLabel(MainApplicationUI.username);
		usernameLbl.setFont(new Font("Tahoma", Font.PLAIN, 11));
		usernameLbl.setBounds(156, 26, 73, 16);
		panel.add(usernameLbl);
		
		JLabel lblCurrentPassword = new JLabel("Current password :");
		lblCurrentPassword.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblCurrentPassword.setBounds(41, 57, 110, 16);
		panel.add(lblCurrentPassword);
		
		JLabel lblNewPassword = new JLabel("New password :");
		lblNewPassword.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblNewPassword.setBounds(58, 87, 99, 16);
		panel.add(lblNewPassword);
		
		JLabel lblVerifypassword = new JLabel("Verify password :");
		lblVerifypassword.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblVerifypassword.setBounds(51, 114, 99, 16);
		panel.add(lblVerifypassword);
		
		JButton btnNewButton = new JButton("Change");
		btnNewButton.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				changePass();
			}
		});
		btnNewButton.setBounds(156, 145, 86, 23);
		panel.add(btnNewButton);
		
		JButton btnCancel = new JButton("Cancel");
		btnCancel.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnCancel.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				MainApplicationUI.changePasswordDialog.dispose();
			}
		});
		btnCancel.setBounds(247, 145, 86, 23);
		panel.add(btnCancel);
		
		resultLabel = new JLabel("");
		resultLabel.setBounds(39, 176, 362, 18);
		panel.add(resultLabel);
		
		currentPassField = new JPasswordField();
		currentPassField.setBounds(156, 55, 247, 23);
		panel.add(currentPassField);
		
		newPassField = new JPasswordField();
		newPassField.setBounds(156, 82, 247, 23);
		panel.add(newPassField);
		
		verifyPassField = new JPasswordField();
		verifyPassField.setBounds(156, 111, 247, 23);
		panel.add(verifyPassField);
	}
	
	@SuppressWarnings("deprecation")
	protected void changePass() {
		currentPassField.setBackground(Color.WHITE);
		newPassField.setBackground(Color.WHITE);
		verifyPassField.setBackground(Color.WHITE);
		
		String username = usernameLbl.getText();
		String currentPass = currentPassField.getText();
		String newPass = newPassField.getText();
		String verifyPass = verifyPassField.getText();
		
		if(StringUtils.isEmpty(newPass)){
			resultLabel.setText("New password cannot be empty");
			resultLabel.setForeground(Color.RED);
			newPassField.setBackground(Color.YELLOW);
			return;
		}
		
		if(!newPass.equalsIgnoreCase(verifyPass)){
			resultLabel.setText("New password and verified password are not the same!");
			resultLabel.setForeground(Color.RED);
			newPassField.setBackground(Color.YELLOW);
			verifyPassField.setBackground(Color.YELLOW);
			return;
		}
		
		currentPass = SecurityUtils.encryptedPass(username, currentPass);
		UserAccount userAccount = UserAccountDAO.getUserAccount(username, currentPass);
		if(userAccount.getRole() <= 0){
			resultLabel.setText("Current Password Incorect");
			resultLabel.setForeground(Color.RED);
			currentPassField.setBackground(Color.YELLOW);
			return;
		}
		
		newPass = SecurityUtils.encryptedPass(username, newPass);
		int updateResult = UserAccountDAO.updatePasswordForUser(username, newPass);
		
		if(updateResult == 0){
			resultLabel.setText("Password is updated successfully!");
			resultLabel.setForeground(Color.BLUE);
		}else{
			resultLabel.setText("Fail to update current password!");
			resultLabel.setForeground(Color.RED);
		}
		
		currentPassField.setText("");
		newPassField.setText("");
		verifyPassField.setText("");
	}
	
}
