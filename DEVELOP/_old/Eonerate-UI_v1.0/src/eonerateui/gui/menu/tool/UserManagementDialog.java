package eonerateui.gui.menu.tool;

import java.awt.Color;
import java.awt.Font;
import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;

import org.apache.commons.lang3.StringUtils;

import eonerateui.db.UserAccountDAO;
import eonerateui.entity.user.UserAccount;
import eonerateui.gui.main.MainApplicationUI;
import eonerateui.gui.util.MySortedJTable;
import eonerateui.gui.util.MyTableModel;
import eonerateui.util.IConstant;
import eonerateui.util.SecurityUtils;


public class UserManagementDialog extends JDialog {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private MySortedJTable listUserJTable;
	private MyTableModel tableModel;
	private int size;
	private ArrayList<UserAccount> listUserAccount = new ArrayList<UserAccount>();
	private JPanel listUserPanel;
	private JLabel updateResultLbl;
	private static final String[] columnNames = {"Username", "Admin", "Rerate", "RCRating", "Viewer"}; // Moniter --> Rerate, Ratig --> RCRating
	static int SUCCESS = 0;
	static int ERROR = -1;
	private JTextField usernameTxt;
	private JPasswordField passwordField;
	private JCheckBox isAdminCheckBox;
	private JCheckBox isMonitorCheckBox;
	private JCheckBox isRatingCheckBox;
	private JCheckBox isViewerCheckBox;
	private JButton btnResetpassword;
	private JLabel lblResult;
	private JFrame frame;
	public static String userAdmin;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			UserManagementDialog dialog = new UserManagementDialog();
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Create the dialog.
	 */
	public UserManagementDialog() {
		setResizable(false);
		setTitle("User Management");
		setBounds(100, 100, 738, 476);
		setModalityType(ModalityType.APPLICATION_MODAL);
		getContentPane().setLayout(null);
		setLocationRelativeTo(null);
//		try {
//			UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
//		} catch(Exception e){
//			e.printStackTrace();
//		}
		UserManagementDialog.setDefaultLookAndFeelDecorated(true);
		
		listUserPanel = new JPanel();
		listUserPanel.setBorder(new TitledBorder(null, "List User", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		listUserPanel.setBounds(9, 111, 713, 292);
		getContentPane().add(listUserPanel);
		listUserPanel.setLayout(null);
		
		drawTable();
		
		JButton btnUpdate = new JButton("Update Role");
		btnUpdate.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnUpdate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				updateRoles();
			}
		});
		btnUpdate.setBounds(220, 414, 98, 23);
		getContentPane().add(btnUpdate);
		
		updateResultLbl = new JLabel("");
		updateResultLbl.setBounds(59, 388, 236, 22);
		getContentPane().add(updateResultLbl);
		
		JPanel panel = new JPanel();
		panel.setLayout(null);
		panel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Create User", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		panel.setBounds(9, 11, 713, 93);
		getContentPane().add(panel);
		
		JLabel label = new JLabel("Username :");
		label.setFont(new Font("Tahoma", Font.PLAIN, 11));
		label.setBounds(41, 27, 73, 14);
		panel.add(label);
		
		JLabel label_1 = new JLabel("Password :");
		label_1.setFont(new Font("Tahoma", Font.PLAIN, 11));
		label_1.setBounds(394, 27, 66, 14);
		panel.add(label_1);
		
		usernameTxt = new JTextField();
		usernameTxt.setColumns(10);
		usernameTxt.setBounds(120, 23, 253, 23);
		panel.add(usernameTxt);
		
		JLabel lblRole = new JLabel("User's role :");
		lblRole.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblRole.setBounds(41, 67, 75, 14);
		panel.add(lblRole);
		
		isAdminCheckBox = new JCheckBox("Admin");
		isAdminCheckBox.setFont(new Font("Tahoma", Font.PLAIN, 11));
		isAdminCheckBox.setBounds(120, 63, 80, 23);
		panel.add(isAdminCheckBox);
		
		isMonitorCheckBox = new JCheckBox("Rerate");
		isMonitorCheckBox.setFont(new Font("Tahoma", Font.PLAIN, 11));
		isMonitorCheckBox.setBounds(217, 63, 80, 23);
		panel.add(isMonitorCheckBox);
		
		isRatingCheckBox = new JCheckBox("RCRating");
		isRatingCheckBox.setFont(new Font("Tahoma", Font.PLAIN, 11));
		isRatingCheckBox.setBounds(320, 63, 75, 23);
		panel.add(isRatingCheckBox);
		
		isViewerCheckBox = new JCheckBox("Viewer");
		isViewerCheckBox.setFont(new Font("Tahoma", Font.PLAIN, 11));
		isViewerCheckBox.setBounds(424, 63, 75, 23);
		panel.add(isViewerCheckBox);
		
		passwordField = new JPasswordField();
		passwordField.setBounds(468, 23, 235, 23);
		panel.add(passwordField);
		
		JButton btnCreate = new JButton("Create");
		btnCreate.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnCreate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				createUser();
			}
		});
		btnCreate.setBounds(139, 414, 71, 23);
		getContentPane().add(btnCreate);
		
		JButton btnDelete = new JButton("Delete");
		btnDelete.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnDelete.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				deleteUser();
			}
		});
		btnDelete.setBounds(328, 414, 71, 23);
		getContentPane().add(btnDelete);
		
		btnResetpassword = new JButton("Reset password");
		btnResetpassword.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnResetpassword.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				resetPassword();
			}
		});
		btnResetpassword.setBounds(10, 414, 119, 23);
		getContentPane().add(btnResetpassword);
		
		lblResult = new JLabel("");
		lblResult.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblResult.setBounds(409, 418, 236, 19);
		getContentPane().add(lblResult);
		
		JButton btnClose = new JButton("Close");
		btnClose.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				UserManagementDialog.this.dispose();
			}
		});
		btnClose.setBounds(651, 414, 71, 23);
		getContentPane().add(btnClose);
		
	}

	@SuppressWarnings("deprecation")
	protected void resetPassword() {
		if(StringUtils.isEmpty(usernameTxt.getText())){
			usernameTxt.setBackground(Color.YELLOW);
			lblResult.setText("username cannot be empty!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if(isContainSpecialCharacter(usernameTxt.getText())){
			usernameTxt.setBackground(Color.YELLOW);
			lblResult.setText("username contain special characters!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if(StringUtils.isEmpty(passwordField.getText())){
			passwordField.setBackground(Color.YELLOW);
			lblResult.setText("password cannot be empty!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if(isContainSpecialCharacter(passwordField.getText())){
			usernameTxt.setBackground(Color.YELLOW);
			lblResult.setText("password contain special characters!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if (JOptionPane.showConfirmDialog(frame, 
	            "Are you sure to reset password for user: " + usernameTxt.getText(), "Really Reset?", 
	            JOptionPane.YES_NO_OPTION,
	            JOptionPane.QUESTION_MESSAGE) == JOptionPane.NO_OPTION){
	    		return;
	    }
		
		String username = usernameTxt.getText();
		String password = passwordField.getText();
		password = SecurityUtils.encryptedPass(username, password);
		int result = UserAccountDAO.updatePassword(username, password);
		if(result == SUCCESS){
			lblResult.setText("Reset user password successfully!");
			lblResult.setForeground(Color.BLUE);
		}else{
			lblResult.setText("Fail to reset user password");
			lblResult.setForeground(Color.RED);
		}
		updateTable();
	}

	protected void deleteUser() {
		if(StringUtils.isEmpty(usernameTxt.getText())){
			usernameTxt.setBackground(Color.YELLOW);
			lblResult.setText("username cannot be empty!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if(isContainSpecialCharacter(usernameTxt.getText())){
			usernameTxt.setBackground(Color.YELLOW);
			lblResult.setText("username contain special characters!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
    	if (JOptionPane.showConfirmDialog(frame, 
	            "Are you sure to delete the user: " + usernameTxt.getText(), "Really Deleteing?", 
	            JOptionPane.YES_NO_OPTION,
	            JOptionPane.QUESTION_MESSAGE) == JOptionPane.NO_OPTION){
	    		return;
	    }
		
		UserAccount userAccount = new UserAccount();
		userAccount.setUsername(usernameTxt.getText());
		int result = UserAccountDAO.deleteUser(userAccount);
		if(result == SUCCESS){
			usernameTxt.setBackground(Color.WHITE);
			lblResult.setText("Delete user successfully!");
			lblResult.setForeground(Color.BLUE);
		}else{
			lblResult.setText("Fail to delete user");
			lblResult.setForeground(Color.RED);
		}
		updateTable();
	}

	@SuppressWarnings("deprecation")
	protected void createUser() {
		if(StringUtils.isEmpty(usernameTxt.getText())){
			usernameTxt.setBackground(Color.YELLOW);
			lblResult.setText("username cannot be empty!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if(isContainSpecialCharacter(usernameTxt.getText())){
			usernameTxt.setBackground(Color.YELLOW);
			lblResult.setText("username contain special characters!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if(StringUtils.isEmpty(passwordField.getText())){
			passwordField.setBackground(Color.YELLOW);
			lblResult.setText("password cannot be empty!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if (JOptionPane.showConfirmDialog(frame, 
	            "Are you sure to create a new user: " + usernameTxt.getText(), "Really Creating ?", 
	            JOptionPane.YES_NO_OPTION,
	            JOptionPane.QUESTION_MESSAGE) == JOptionPane.NO_OPTION){
	    		return;
	    }
		
		String username = usernameTxt.getText();
		String password = passwordField.getText();
		password = SecurityUtils.encryptedPass(username, password);
		int role = getNewRole(isAdminCheckBox.isSelected(), isMonitorCheckBox.isSelected(), isRatingCheckBox.isSelected(), isViewerCheckBox.isSelected());
		UserAccount userAccount = new UserAccount(username, password, role, MainApplicationUI.username, null);
		int result = UserAccountDAO.createUser(userAccount);
		if(result == SUCCESS){
			usernameTxt.setBackground(Color.WHITE);
			lblResult.setText("Create user successfully!");
			lblResult.setForeground(Color.BLUE);
		}else{
			lblResult.setText("Fail to create user");
			lblResult.setForeground(Color.RED);
		}
		updateTable();
	}

	private void drawTable() {
		tableModel = new MyTableModel();
		tableModel.setColumnNames(columnNames);
		
		listUserAccount  = UserAccountDAO.getListUserAccount();
		size = listUserAccount.size();
		if(size > 0){
			Object[][] data = new Object[size][columnNames.length];
			for(int i = 0 ; i < size ; i ++){
				data[i][0] = listUserAccount.get(i).getUsername();
				int role = listUserAccount.get(i).getRole();
				data[i][1] = (role == 1) ? true : false;
				data[i][2] = (role == 2) ? true : false;
				data[i][3] = (role == 3) ? true : false;
				data[i][4] = (role == 4) ? true : false;
			}
			tableModel.setData(data);
		}
		
		listUserJTable = new MySortedJTable(tableModel);
		listUserJTable.setBounds(10, 26, 693, 255);
		listUserPanel.add(listUserJTable);
		
		listUserJTable.getTable().addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent me) {
                JTable table =(JTable) me.getSource();
                Point p = me.getPoint();
                int selectedRow = table.rowAtPoint(p);
                if (me.getClickCount() == 1) {
                	String username = (String)listUserJTable.getTable().getModel().getValueAt(selectedRow, 0);
                	//String password = listUserAccount.get(selectedRow).getPassword();
                	Boolean isAdmin = (Boolean)listUserJTable.getTable().getValueAt(selectedRow, 1);
                	Boolean isMonitor = (Boolean)listUserJTable.getTable().getValueAt(selectedRow, 2);
                	Boolean isRating = (Boolean)listUserJTable.getTable().getValueAt(selectedRow, 3);
                	Boolean isViewer = (Boolean)listUserJTable.getTable().getValueAt(selectedRow, 4);
                	
                	setRowValue(username, isAdmin, isMonitor, isRating, isViewer);
                }
            }
        });
	}
	
	public void updateTable(){
		listUserAccount  = UserAccountDAO.getListUserAccount();
		size = listUserAccount.size();
		if(size > 0){
			Object[][] data = new Object[size][columnNames.length];
			for(int i = 0 ; i < size ; i ++){
				data[i][0] = listUserAccount.get(i).getUsername();
				int role = listUserAccount.get(i).getRole();
				data[i][1] = (role == 1) ? true : false;
				data[i][2] = (role == 2) ? true : false;
				data[i][3] = (role == 3) ? true : false;
				data[i][4] = (role == 4) ? true : false;
			}
			tableModel.setData(data);
		}
		listUserJTable.repaint();
	
		usernameTxt.setText("");
		passwordField.setText("");
		isAdminCheckBox.setSelected(false);
		isMonitorCheckBox.setSelected(false);
		isRatingCheckBox.setSelected(false);
		isViewerCheckBox.setSelected(false);
	}

	public void setRowValue(String userName, Boolean isAdmin, Boolean isMonitor, Boolean isRating, Boolean isViewer){
		usernameTxt.setText(userName);
		//passwordField.setText(password);
		if(isAdmin) isAdminCheckBox.setSelected(true);
		else isAdminCheckBox.setSelected(false);
		
		if(isMonitor) isMonitorCheckBox.setSelected(true);
		else isMonitorCheckBox.setSelected(false);
		
		if(isRating) isRatingCheckBox.setSelected(true);
		else isRatingCheckBox.setSelected(false);
		
		if(isViewer) isViewerCheckBox.setSelected(true);
		else isViewerCheckBox.setSelected(false);
	}
	
	protected void updateRoles() {
		if(StringUtils.isEmpty(usernameTxt.getText())){
			usernameTxt.setBackground(Color.YELLOW);
			lblResult.setText("username cannot be empty!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if(isContainSpecialCharacter(usernameTxt.getText())){
			usernameTxt.setBackground(Color.YELLOW);
			lblResult.setText("username contain special characters!");
			lblResult.setForeground(Color.RED);
			return;
		}
		
		if (JOptionPane.showConfirmDialog(frame, 
	            "Are you sure to update the user: " + usernameTxt.getText(), "Really Updating ?", 
	            JOptionPane.YES_NO_OPTION,
	            JOptionPane.QUESTION_MESSAGE) == JOptionPane.NO_OPTION){
	    		return;
	    }
		
		String username = usernameTxt.getText();
		int role = getNewRole(isAdminCheckBox.isSelected(), isMonitorCheckBox.isSelected(), isRatingCheckBox.isSelected(), isViewerCheckBox.isSelected());
		UserAccount userAccount = new UserAccount();
		userAccount.setUsername(username);
		userAccount.setRole(role);
		int result = UserAccountDAO.updateRoleForUser(userAccount);
		if(result == SUCCESS){
			usernameTxt.setBackground(Color.WHITE);
			lblResult.setText("Update user successfully!");
			lblResult.setForeground(Color.BLUE);
		}else{
			lblResult.setText("Fail to update user");
			lblResult.setForeground(Color.RED);
		}
		updateTable();
	}
	

	/**
	 *  check the special characters in s.
	 */

	 public static Boolean isContainSpecialCharacter(String s) {
		 Pattern regex = Pattern.compile("['\\/.{}!%^*()$&+,:;=?@#| ]");
		 Matcher matcher = regex.matcher(s);
		 if (matcher.find()){
		     return true;
		 }else return false;
	 }
	 
	public static int getNewRole(Boolean isAdmin, Boolean isMonitor, Boolean isRating, Boolean isViewer){
		if((isAdmin) || (isMonitor && isRating)){
			return IConstant.USER_ROLE_CODE.ADMIN;
		}
		if(isMonitor){
			return IConstant.USER_ROLE_CODE.MONITOR;
		}
		if(isRating){
			return IConstant.USER_ROLE_CODE.RATING_RC;
		}
		if(isViewer){
			return IConstant.USER_ROLE_CODE.VIEWER;
		}
		return IConstant.USER_ROLE_CODE.VIEWER;
	}

}
