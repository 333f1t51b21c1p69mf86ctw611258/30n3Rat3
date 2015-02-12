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
public class RatingUsageConfigDialog extends JDialog {

	private JTextArea resultTextArea;
	private String newLine = "\n";
	private JButton buttonClose;
	private JTextField inputTableTextField;
	private JTextField outputTableTextField;
	private static String oldInputTableValue;
	private static String oldOutputTableValue;

	
	public static void main(String[] args) {
		try {
			RatingUsageConfigDialog dialog = new RatingUsageConfigDialog();
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Create the dialog.
	 */
	public RatingUsageConfigDialog() {
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setTitle("Usage Rating Config");
		setModalityType(ModalityType.APPLICATION_MODAL);
		setResizable(false);
		setBounds(100, 100, 467, 367);
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		{
			JPanel inputLbl = new JPanel();
			inputLbl.setLayout(null);
			inputLbl.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Data Config", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
			inputLbl.setBounds(10, 11, 436, 147);
			getContentPane().add(inputLbl);
			
			JLabel label = new JLabel("Input:");
			label.setFont(new Font("Tahoma", Font.PLAIN, 11));
			label.setBounds(76, 48, 45, 16);
			inputLbl.add(label);
			
			inputTableTextField = new JTextField();
			inputTableTextField.setFont(new Font("Tahoma", Font.PLAIN, 11));
			inputTableTextField.setText("");
			inputTableTextField.setColumns(10);
			inputTableTextField.setBounds(131, 42, 233, 29);
			inputLbl.add(inputTableTextField);
			
			outputTableTextField = new JTextField();
			outputTableTextField.setFont(new Font("Tahoma", Font.PLAIN, 11));
			outputTableTextField.setText("");
			outputTableTextField.setColumns(10);
			outputTableTextField.setBounds(131, 80, 233, 29);
			inputLbl.add(outputTableTextField);
			
			JLabel outputLbl = new JLabel("Output:");
			outputLbl.setFont(new Font("Tahoma", Font.PLAIN, 11));
			outputLbl.setBounds(70, 86, 51, 16);
			inputLbl.add(outputLbl);
			
			
			
		}
		
		JPanel resultPanel = new JPanel();
		resultPanel.setLayout(null);
		resultPanel.setBorder(new TitledBorder(null, "Result", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		resultPanel.setBounds(10, 157, 436, 142);
		getContentPane().add(resultPanel);
		
		resultTextArea = new JTextArea();
		resultTextArea.setText("");
		resultTextArea.setForeground(Color.BLACK);
		resultTextArea.setBounds(12, 22, 409, 96);
		resultPanel.add(resultTextArea);
		
		JButton btnSubmit = new JButton("Submit");
		btnSubmit.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnSubmit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				updatePipelineConfig();
			}
		});
		btnSubmit.setBounds(163, 310, 74, 23);
		getContentPane().add(btnSubmit);
		
		buttonClose = new JButton("Close");
		buttonClose.setFont(new Font("Tahoma", Font.PLAIN, 11));
		buttonClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				RatingUsageConfigDialog.this.dispose();
			}
		});
		buttonClose.setBounds(247, 310, 74, 23);
		getContentPane().add(buttonClose);
		init();
	}
	

	protected void updatePipelineConfig() {
		String inputTable = inputTableTextField.getText();
		String outputTable = outputTableTextField.getText();
		AdapterConfig adapterConfig = new AdapterConfig(inputTable, outputTable, null);
		int updateResult = MainProcessor.updateAdapaterConfig(oldInputTableValue, oldOutputTableValue, adapterConfig);
		if(updateResult == CodeConstants.COMMON.SUCCESS){
			resultTextArea.setText("");
			resultTextArea.setText(newLine);
			resultTextArea.append(MessageConstants.ADAPTER_CONFIGURATION.SUCCESS);
			resultTextArea.setForeground(Color.BLUE);
		}else{
			resultTextArea.setText("");
			resultTextArea.setText(newLine);
			resultTextArea.append(MessageConstants.ADAPTER_CONFIGURATION.FAIL);
			resultTextArea.setForeground(Color.RED);
		}
	}
	
	public void init(){
		resultTextArea.setText("");
		resultTextArea.setForeground(Color.black);
		/*
		 * load input and output table from xml
		 */
		AdapterConfig adapterConfig = MainProcessor.loadInputAdapterConfigurationFromXml();
		oldInputTableValue = adapterConfig.getInputTable();
		oldOutputTableValue = adapterConfig.getOutputTable();
		inputTableTextField.setText(adapterConfig.getInputTable());
		outputTableTextField.setText(adapterConfig.getOutputTable());
	}
}
