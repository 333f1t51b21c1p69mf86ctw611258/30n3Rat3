package eonerateui.gui.menu.configuration;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextArea;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;

import eonerateui.controller.main.MainProcessor;
import eonerateui.util.CodeConstants;
import eonerateui.util.MessageConstants;
import java.awt.Font;

@SuppressWarnings("serial")
public class PipelineConfigDialog extends JDialog {

	private JTextArea resultTextArea;
	private String newLine = "\n";
	private JButton buttonClose;
	private ArrayList<PipelineConfig> listPipeline;
	private ArrayList<ButtonGroup> listButtonGroups;

	
	public static void main(String[] args) {
		try {
			PipelineConfigDialog dialog = new PipelineConfigDialog();
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Create the dialog.
	 */
	public PipelineConfigDialog() {
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setTitle("Pipeline Config");
		setModalityType(ModalityType.APPLICATION_MODAL);
		setResizable(false);
		setBounds(100, 100, 467, 382);
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		{
			JPanel inputPanel = new JPanel();
			inputPanel.setLayout(null);
			inputPanel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "PipelineList", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
			inputPanel.setBounds(10, 11, 436, 169);
			getContentPane().add(inputPanel);
			
			
			listPipeline = MainProcessor.loadPipelineConfig();
			listButtonGroups = new ArrayList<ButtonGroup>();
			
			for (int i = 0 ; i < listPipeline.size() ; i ++){
				listButtonGroups.add(new ButtonGroup());
				//adding label
				JLabel lblConfigName = new JLabel(listPipeline.get(i).getPipelineName());
				lblConfigName.setBounds(52, 36 + 40*i, 121, 14);
				inputPanel.add(lblConfigName);
				
				//adding radio button
				JRadioButton isEnableRdb = new JRadioButton("Active");
				isEnableRdb.setBounds(188, 31 + 40*i, 76, 25); 
				isEnableRdb.setActionCommand("true");
				inputPanel.add(isEnableRdb);
				
				JRadioButton isDisableRdb = new JRadioButton("Deactive");
				isDisableRdb.setBounds(289, 31 + 40*i, 90, 25);
				isDisableRdb.setActionCommand("false");
				inputPanel.add(isDisableRdb);
				
				listButtonGroups.get(i).add(isEnableRdb);
				listButtonGroups.get(i).add(isDisableRdb);
				if(listPipeline.get(i).getIsActive()){
					isEnableRdb.setSelected(true);
					isDisableRdb.setSelected(false);
				}else{
					isDisableRdb.setSelected(false);
					isDisableRdb.setSelected(true);
					}
			}
		}
		
		JPanel resultPanel = new JPanel();
		resultPanel.setLayout(null);
		resultPanel.setBorder(new TitledBorder(null, "Result", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		resultPanel.setBounds(12, 178, 436, 130);
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
		btnSubmit.setBounds(152, 319, 86, 29);
		getContentPane().add(btnSubmit);
		
		buttonClose = new JButton("Close");
		buttonClose.setFont(new Font("Tahoma", Font.PLAIN, 11));
		buttonClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				PipelineConfigDialog.this.dispose();
			}
		});
		buttonClose.setBounds(264, 319, 86, 29);
		getContentPane().add(buttonClose);
		
	}
	

	protected void updatePipelineConfig() {
		for ( int i = 0 ; i < listPipeline.size() ; i++){
			String value = listButtonGroups.get(i).getSelection().getActionCommand();
			listPipeline.get(i).setIsActive(value);
		}
		int updateResult = MainProcessor.updatePipelineConfig(listPipeline);
		if(updateResult == CodeConstants.COMMON.SUCCESS){
			resultTextArea.setText("");
			resultTextArea.setText(newLine);
			resultTextArea.append(MessageConstants.PIPELINE_CONFIGURATION.SUCCESS);
			resultTextArea.setForeground(Color.BLUE);
		}else{
			resultTextArea.setText("");
			resultTextArea.setText(newLine);
			resultTextArea.append(MessageConstants.PIPELINE_CONFIGURATION.FAIL);
			resultTextArea.setForeground(Color.RED);
		}
	}
	
	public void init(){
		resultTextArea.setText("");
		resultTextArea.setForeground(Color.black);
	}
}
