package eonerateui.gui.menu.configuration;

import java.awt.Color;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;

import org.apache.commons.lang3.StringUtils;

import eonerateui.db.RCTariffDAO;
import eonerateui.db.pool.DBPool;
import eonerateui.util.RCTariff;




public class UpdateRCTariffDialog extends JDialog {

	/**
	 * 
	 */

	private static final long serialVersionUID = 1L;

	static int SUCCESS = 0;
	static int ERROR = -1;
	private JLabel lblResult;
	private JFrame frame;
	private JTextField txtValue;

	private JCheckBox chkfull;

	
	private Integer Id;
	private JLabel lblproduct;
	

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			UpdateRCTariffDialog dialog = new UpdateRCTariffDialog("","","",0,0,0,false);
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	/**
	 * Create the dialog.
	 */
	public UpdateRCTariffDialog( String offerName, String typeName,String statusName,int day,Integer id,int value,Boolean fullcycle) {
		Id=id;
		setResizable(false);
		setTitle("RC Tariff");
		setBounds(100, 100, 582, 253);
		setModalityType(ModalityType.APPLICATION_MODAL);
		getContentPane().setLayout(null);
		setLocationRelativeTo(null);
	
	/*	try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch(Exception e){
			e.printStackTrace();
		}
		UpdateRCTariffDialog.setDefaultLookAndFeelDecorated(true);*/

		JPanel panel = new JPanel();
		panel.setLayout(null);
		panel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		panel.setBounds(9, 0, 561, 180);
		getContentPane().add(panel);
		
		JLabel lblCode = new JLabel("Product offer");
		lblCode.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblCode.setBounds(10, 23, 96, 23);
		panel.add(lblCode);
		
		JLabel lblNwgroup = new JLabel("RC Tariff type");
		lblNwgroup.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblNwgroup.setBounds(10, 47, 96, 23);
		panel.add(lblNwgroup);
		
		txtValue = new JTextField();
		txtValue.setColumns(10);
		txtValue.setText(Integer.toString(value));
		txtValue.setBounds(138, 143, 156, 23);
		panel.add(txtValue);
		
		chkfull = new JCheckBox("");
		chkfull.setBounds(138, 122, 97, 14);
		if(fullcycle) chkfull.setSelected(true);
		else chkfull.setSelected(false);
		panel.add(chkfull);
		
		JLabel lblNewLabel = new JLabel("Subscriber status");
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblNewLabel.setBounds(10, 72, 106, 23);
		panel.add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("Full cycle");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblNewLabel_1.setBounds(10, 122, 96, 23);
		panel.add(lblNewLabel_1);
		
		JLabel lblVa = new JLabel("Value");
		lblVa.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblVa.setBounds(10, 144, 96, 23);
		panel.add(lblVa);
		
		JLabel lblFromDay = new JLabel("Day");
		lblFromDay.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblFromDay.setBounds(10, 97, 96, 23);
		panel.add(lblFromDay);
		
		lblproduct = new JLabel();
		lblproduct.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblproduct.setText(offerName);
		lblproduct.setBounds(138, 27, 413, 19);
		panel.add(lblproduct);
		
		JLabel lblType_Tariff = new JLabel(typeName);
		lblType_Tariff.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblType_Tariff.setBounds(138, 51, 413, 19);
		panel.add(lblType_Tariff);
		
		JLabel lblSubscriber_status = new JLabel(statusName);
		lblSubscriber_status.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblSubscriber_status.setBounds(138, 76, 413, 19);
		panel.add(lblSubscriber_status);
		
		JLabel lbl_Day = new JLabel(Integer.toString(day));
		lbl_Day.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lbl_Day.setBounds(138, 101, 223, 14);
		panel.add(lbl_Day);
		
		final JButton btnCreate = new JButton("Save");
		btnCreate.setFont(new Font("Tahoma", Font.BOLD, 11));
	
		btnCreate.setBounds(151, 191, 71, 23);
		getContentPane().add(btnCreate);
		
		lblResult = new JLabel("");
		lblResult.setBounds(369, 354, 186, 19);
		getContentPane().add(lblResult);
		
		JButton btnClose = new JButton("Close");
		btnClose.setFont(new Font("Tahoma", Font.BOLD, 11));
		btnClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				UpdateRCTariffDialog.this.dispose();
			}
		});
		btnClose.setBounds(232, 191, 71, 23);
		getContentPane().add(btnClose);
		
		btnCreate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				upDate() ;
				
			}
		});
	}

	public boolean isInteger(String str) {
	    int size = str.length();

	    for (int i = 0; i < size; i++) {
	        if (!Character.isDigit(str.charAt(i))) {
	            return false;
	        }
	    }
	    return size > 0;
	}

	protected void upDate() {
	
		if(StringUtils.isEmpty(txtValue.getText().trim())){
				JOptionPane.showMessageDialog(frame, "You must enter value");
				txtValue.setBackground(Color.YELLOW);
				return;
		}
		if(!isInteger(txtValue.getText().trim()))
		{
			JOptionPane.showMessageDialog(frame, "To day must be number");
			txtValue.setBackground(Color.YELLOW);
			return;
		}
		Integer chk=0;
		if(chkfull.isSelected())
		{
			chk=1;
		}
		try{
			Connection conn = DBPool.getConnection();
			//System.out.println(offerId);
			RCTariff rcTariff = new RCTariff(0, 0,0,0,Integer.parseInt(txtValue.getText()),chk,Id);
			int result = RCTariffDAO.updateRCTariff(rcTariff, conn);
			if(result == SUCCESS){
				
				JOptionPane.showMessageDialog(frame, "Update successfull");
			}
			RCTariffDialog.updateTable();
			UpdateRCTariffDialog.this.dispose();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public void setRowValue(String day, String productname, String typeId,String statusId,String value,Boolean fullcycle){
      
      	 chkfull.setSelected(fullcycle);
	
	}
	
}
