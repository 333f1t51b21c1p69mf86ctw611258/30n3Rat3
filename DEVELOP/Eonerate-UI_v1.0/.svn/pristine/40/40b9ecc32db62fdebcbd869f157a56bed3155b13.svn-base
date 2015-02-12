package eonerateui.gui.menu.tool;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;

import org.apache.commons.io.FileUtils;

import eonerateui.util.IConstant;
import eonerateui.util.MessageConstants;
import java.awt.Font;

public class LogManagementDialog extends JDialog {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private JTextField urLogFolderTxt;
	private JTextField urBadFolderTxt;
	private JTextField rcLogFolderTxt;
	private JTextField rcBadFolderTxt;
	private static String rc_log_url;
	private static String rc_bad_url;
	private static String usage_log_path;
	private static String usage_bad_path;
	private static JFrame frame = new JFrame();

	/**
	 * Create the dialog.
	 */
	public LogManagementDialog() {
		setResizable(false);
		setTitle("Log Management");
		setBounds(100, 100, 658, 278);
		setModalityType(ModalityType.APPLICATION_MODAL);
		getContentPane().setLayout(null);
		setLocationRelativeTo(null);
//		try {
//			UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
//		} catch(Exception e){
//			e.printStackTrace();
//		}
		LogManagementDialog.setDefaultLookAndFeelDecorated(true);
		
		JPanel UsageRatingPanel = new JPanel();
		UsageRatingPanel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Usage Rating", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		UsageRatingPanel.setBounds(10, 11, 622, 103);
		getContentPane().add(UsageRatingPanel);
		UsageRatingPanel.setLayout(null);
		
		JLabel lblLogFolder = new JLabel("Log Folder:");
		lblLogFolder.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblLogFolder.setBounds(44, 32, 65, 14);
		UsageRatingPanel.add(lblLogFolder);
		
		urLogFolderTxt = new JTextField();
		urLogFolderTxt.setEditable(false);
		urLogFolderTxt.setBounds(119, 28, 377, 23);
		UsageRatingPanel.add(urLogFolderTxt);
		urLogFolderTxt.setColumns(10);
		
		JLabel lblBadFolder = new JLabel("Bad Folder:");
		lblBadFolder.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblBadFolder.setBounds(44, 67, 65, 14);
		UsageRatingPanel.add(lblBadFolder);
		
		urBadFolderTxt = new JTextField();
		urBadFolderTxt.setEditable(false);
		urBadFolderTxt.setColumns(10);
		urBadFolderTxt.setBounds(119, 62, 377, 23);
		UsageRatingPanel.add(urBadFolderTxt);
		
		JButton btnUrDeleteLogFolder = new JButton("Delete");
		btnUrDeleteLogFolder.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnUrDeleteLogFolder.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				emptyFolder(urLogFolderTxt.getText());
			}
		});
		btnUrDeleteLogFolder.setBounds(518, 28, 94, 23);
		UsageRatingPanel.add(btnUrDeleteLogFolder);
		
		JButton btnUrDeleteBadFolder = new JButton("Delete");
		btnUrDeleteBadFolder.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnUrDeleteBadFolder.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				emptyFolder(urBadFolderTxt.getText());
			}
		});
		btnUrDeleteBadFolder.setBounds(518, 63, 94, 23);
		UsageRatingPanel.add(btnUrDeleteBadFolder);
		
		JPanel rcRatingPanel = new JPanel();
		rcRatingPanel.setLayout(null);
		rcRatingPanel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "RC Rating", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		rcRatingPanel.setBounds(10, 125, 622, 103);
		getContentPane().add(rcRatingPanel);
		
		JLabel label = new JLabel("Log Folder:");
		label.setFont(new Font("Tahoma", Font.PLAIN, 11));
		label.setBounds(44, 32, 65, 14);
		rcRatingPanel.add(label);
		
		rcLogFolderTxt = new JTextField();
		rcLogFolderTxt.setEditable(false);
		rcLogFolderTxt.setColumns(10);
		rcLogFolderTxt.setBounds(119, 28, 375, 23);
		rcRatingPanel.add(rcLogFolderTxt);
		
		JLabel label_1 = new JLabel("Bad Folder:");
		label_1.setFont(new Font("Tahoma", Font.PLAIN, 11));
		label_1.setBounds(44, 67, 65, 14);
		rcRatingPanel.add(label_1);
		
		rcBadFolderTxt = new JTextField();
		rcBadFolderTxt.setEditable(false);
		rcBadFolderTxt.setColumns(10);
		rcBadFolderTxt.setBounds(119, 62, 375, 23);
		rcRatingPanel.add(rcBadFolderTxt);
		
		JButton btnRcDeleteLogFolder = new JButton("Delete");
		btnRcDeleteLogFolder.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnRcDeleteLogFolder.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				emptyFolder(rcLogFolderTxt.getText());
			}
		});
		btnRcDeleteLogFolder.setBounds(518, 28, 94, 23);
		rcRatingPanel.add(btnRcDeleteLogFolder);
		
		JButton btnRcDeleteBadFolder = new JButton("Delete");
		btnRcDeleteBadFolder.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnRcDeleteBadFolder.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				emptyFolder(rcBadFolderTxt.getText());
			}
		});
		btnRcDeleteBadFolder.setBounds(518, 63, 94, 23);
		rcRatingPanel.add(btnRcDeleteBadFolder);
		
		init();
	}

	/**
	 * @TODO delete all file in folder
	 * @param filePath
	 */
	protected void emptyFolder(String filePath) {
		try {
			int dialogResult = JOptionPane.showConfirmDialog(frame, MessageConstants.LOG_MANAGEMENT.ASK_FOR_DELETE, "Confirmation",JOptionPane.YES_NO_OPTION);
			if(dialogResult == JOptionPane.YES_OPTION){
				FileUtils.cleanDirectory(new File(filePath));	
			}else{
				return;
			}
		} catch (IOException e) {
			e.getMessage();
			JOptionPane.showMessageDialog(frame, MessageConstants.LOG_MANAGEMENT.DELETE_FAIL + e.getMessage());
		}
		JOptionPane.showMessageDialog(frame, MessageConstants.LOG_MANAGEMENT.DELETE_SUCCESS);
	}

	/*
	 * load url from file config
	 */
	private void init() {
		try {
			loadProperties();
			urLogFolderTxt.setText(usage_log_path);
			urBadFolderTxt.setText(usage_bad_path);
			rcLogFolderTxt.setText(rc_log_url);
			rcBadFolderTxt.setText(rc_bad_url);
		} catch (IOException e) {
			System.out.println("IOException: " + e.getMessage());
		}
	}
	
	private static void loadProperties() throws IOException {
		String fileName = IConstant.ROOT_CONFIG.CONFIG_FOLDER_PATH + "program.conf";
		Properties props = new Properties();
		props.load(new FileInputStream(fileName));    
		rc_log_url = props.getProperty("rc_log_url", rc_log_url);
		rc_bad_url = props.getProperty("rc_bad_url", rc_bad_url);
		usage_log_path = props.getProperty("usage_log_path", usage_log_path);
		usage_bad_path = props.getProperty("usage_bad_path", usage_bad_path);
	}
}
