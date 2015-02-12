package eonerateui.gui.menu.configuration;

import java.awt.Color;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;

import javax.swing.JRadioButton;

import eonerateui.controller.main.MainProcessor;
import eonerateui.util.CodeConstants;
import eonerateui.util.MessageConstants;

@SuppressWarnings("serial")
public class ProcessConfigDialog extends JDialog {
	private String newLine = "\n";
	private JTextArea resultTextArea;
	private ArrayList<ProcessConfig> listProcess;
	private ArrayList<ButtonGroup> listButtonGroups;

	/**
	 * Create the dialog.
	 */
	public ProcessConfigDialog() {
		setModalityType(ModalityType.APPLICATION_MODAL);
		setResizable(false);
//		try {
//			UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
//		} catch(Exception e){
//			e.printStackTrace();
//		}
		ProcessConfigDialog.setDefaultLookAndFeelDecorated(true);
		
		setTitle("Process Configuration");
		setBounds(100, 100, 723, 521);
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		
		JPanel inputPanel = new JPanel();
		inputPanel.setBorder(new TitledBorder(null, "Input Information", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		inputPanel.setBounds(7, 11, 323, 430);
		getContentPane().add(inputPanel);
		inputPanel.setLayout(null);

		//step 1: Get the list Process config from xml file
		listProcess = MainProcessor.loadProcessConfig();
		listButtonGroups = new ArrayList<ButtonGroup>();
		for (int i = 0 ; i < listProcess.size() ; i ++){
			listButtonGroups.add(new ButtonGroup());
			//adding label
			JLabel lblConfigName = new JLabel(listProcess.get(i).getName());
			lblConfigName.setFont(new Font("Tahoma", Font.BOLD, 11));
			lblConfigName.setBounds(30, 46 + 40*i, 120, 25);
			inputPanel.add(lblConfigName);
			//adding radio button
			JRadioButton isEnableRdb = new JRadioButton("Enable");
			isEnableRdb.setBounds(162, 46 + 40*i, 73, 25); 
			isEnableRdb.setActionCommand("true");
			inputPanel.add(isEnableRdb);
					
			JRadioButton isDisableRdb = new JRadioButton("Disable");
			isDisableRdb.setBounds(236, 46 + 40*i, 79, 25);
			isDisableRdb.setActionCommand("false");
			inputPanel.add(isDisableRdb);
					
			//add radio button to button group
			listButtonGroups.get(i).add(isEnableRdb);
			listButtonGroups.get(i).add(isDisableRdb);
			if(listProcess.get(i).getIsActive()){
				isEnableRdb.setSelected(true);
				isDisableRdb.setSelected(false);
			}else{
				isDisableRdb.setSelected(false);
				isDisableRdb.setSelected(true);
				}
		}
		
		JButton btnSubmit = new JButton("Submit");
		btnSubmit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				updateProcessConfig();
			}
		});
		btnSubmit.setBounds(493, 452, 97, 29);
		getContentPane().add(btnSubmit);
		
		JPanel resultPanel = new JPanel();
		resultPanel.setLayout(null);
		resultPanel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Result", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		resultPanel.setBounds(336, 11, 368, 430);
		getContentPane().add(resultPanel);
		
		resultTextArea = new JTextArea();
		resultTextArea.setBounds(12, 23, 344, 395);
		resultPanel.add(resultTextArea);
		
		JButton buttonClose = new JButton("Close");
		buttonClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				ProcessConfigDialog.this.dispose();
			}
		});
		buttonClose.setBounds(607, 452, 97, 29);
		getContentPane().add(buttonClose);
		
	}
	
	protected void updateProcessConfig() {
		for ( int i = 0 ; i < listProcess.size() ; i++){
			String value = listButtonGroups.get(i).getSelection().getActionCommand();
			listProcess.get(i).setIsActive(value);
		}
		int updateResult = MainProcessor.updateProcessConfig(listProcess);
		if(updateResult == CodeConstants.COMMON.SUCCESS){
			resultTextArea.setText("");
			resultTextArea.setText(newLine  );
			resultTextArea.append(MessageConstants.PROCESS_CONFIGURATION.SUCCESS);
			resultTextArea.setForeground(Color.BLUE);
		}else{
			resultTextArea.setText("");
			resultTextArea.setText(newLine );
			resultTextArea.append(MessageConstants.PROCESS_CONFIGURATION.FAIL);
			resultTextArea.setForeground(Color.RED);
		}
	}

	public void init() {
	resultTextArea.setText("");
}
	
	
}
