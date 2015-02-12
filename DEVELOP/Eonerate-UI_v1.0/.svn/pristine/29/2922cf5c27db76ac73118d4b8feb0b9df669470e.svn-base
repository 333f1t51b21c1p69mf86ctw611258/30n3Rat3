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




public class QuickRCTariffDialog extends JDialog {

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

	private JTextField txtFromDay;
	private JTextField toDayTxt;
	private JLabel lblproduct;
	
	public static Integer offerId;
	public static Integer typeId;
	public static Integer statusId;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			QuickRCTariffDialog dialog = new QuickRCTariffDialog(0,"",0,"",0,"");
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	/**
	 * Create the dialog.
	 */
	public QuickRCTariffDialog(int offId, String offerName,int tyId, String typeName,int staId, String statusName) {
		offerId=offId;
		typeId=tyId;
		statusId=staId;
		setResizable(false);
		setTitle("RC Tariff");
		setBounds(100, 100, 582, 220);
		setModalityType(ModalityType.APPLICATION_MODAL);
		getContentPane().setLayout(null);
		setLocationRelativeTo(null);
	
	/*	try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch(Exception e){
			e.printStackTrace();
		}
		QuickRCTariffDialog.setDefaultLookAndFeelDecorated(true);*/
		
	
		
		
		JPanel panel = new JPanel();
		panel.setLayout(null);
		panel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		panel.setBounds(9, 0, 561, 147);
		getContentPane().add(panel);
		
		JLabel lblCode = new JLabel("Product offer");
		lblCode.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblCode.setBounds(10, 11, 112, 23);
		panel.add(lblCode);
		
		JLabel lblNwgroup = new JLabel("RC Tariff type");
		lblNwgroup.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblNwgroup.setBounds(10, 33, 112, 23);
		panel.add(lblNwgroup);
		
		txtValue = new JTextField();
		txtValue.setColumns(10);
		txtValue.setBounds(131, 113, 156, 23);
		txtValue.setText("");
		panel.add(txtValue);
		
		chkfull = new JCheckBox("");
		chkfull.setBounds(393, 113, 29, 23);
		panel.add(chkfull);
		
		JLabel lblNewLabel = new JLabel("Subscriber status");
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblNewLabel.setBounds(9, 56, 119, 23);
		panel.add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("Full cycle");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblNewLabel_1.setBounds(308, 113, 66, 23);
		panel.add(lblNewLabel_1);
		
		JLabel lblVa = new JLabel("Value");
		lblVa.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblVa.setBounds(10, 113, 48, 23);
		panel.add(lblVa);
		
		txtFromDay = new JTextField();
		txtFromDay.setColumns(10);
		txtFromDay.setBounds(131, 83, 156, 23);
		txtFromDay.setText("");
		panel.add(txtFromDay);
		
		toDayTxt = new JTextField();
		toDayTxt.setColumns(10);
		toDayTxt.setBounds(393, 83, 156, 23);
		toDayTxt.setText("");
		panel.add(toDayTxt);
		
		JLabel lblToDay = new JLabel("To day");
		lblToDay.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblToDay.setBounds(308, 83, 66, 23);
		panel.add(lblToDay);
		
		JLabel lblFromDay = new JLabel("From day");
		lblFromDay.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblFromDay.setBounds(10, 83, 89, 23);
		panel.add(lblFromDay);
		
		lblproduct = new JLabel();
		lblproduct.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblproduct.setText(offerName);
		lblproduct.setBounds(134, 13, 417, 19);
		panel.add(lblproduct);
		
		JLabel lblType_Tariff = new JLabel(typeName);
		lblType_Tariff.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblType_Tariff.setBounds(132, 35, 408, 19);
		panel.add(lblType_Tariff);
		
		JLabel lblSubscriber_status = new JLabel(statusName);
		lblSubscriber_status.setFont(new Font("Tahoma", Font.PLAIN, 11));
		lblSubscriber_status.setBounds(132, 58, 391, 19);
		panel.add(lblSubscriber_status);
		
		final JButton btnCreate = new JButton("Save");
		btnCreate.setFont(new Font("Tahoma", Font.BOLD, 11));
	
		btnCreate.setBounds(224, 158, 71, 23);
		getContentPane().add(btnCreate);
		
		lblResult = new JLabel("");
		lblResult.setBounds(369, 354, 186, 19);
		getContentPane().add(lblResult);
		
		JButton btnClose = new JButton("Close");
		btnClose.setFont(new Font("Tahoma", Font.BOLD, 11));
		btnClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				QuickRCTariffDialog.this.dispose();
			}
		});
		btnClose.setBounds(331, 158, 71, 23);
		getContentPane().add(btnClose);
		
		btnCreate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				createZoneMap() ;
				
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


	protected void createZoneMap() {
		
		boolean checkExistTariff=false;
		
		if(StringUtils.isEmpty(txtFromDay.getText())){
			JOptionPane.showMessageDialog(frame, "From day cannot be empty!");
			txtFromDay.setBackground(Color.YELLOW);
			return;
		}
		
		if(!isInteger(txtFromDay.getText().trim()))
		{
			JOptionPane.showMessageDialog(frame, "From day must be number");
			txtFromDay.setBackground(Color.YELLOW);
			return;
		}
		
		if(isInteger(txtFromDay.getText().trim()))
		{
			if( Integer.parseInt(txtFromDay.getText().trim()) <=0 )
			{
				JOptionPane.showMessageDialog(frame, "Enter value from 0 to 31");
				txtFromDay.setBackground(Color.YELLOW);
				return;
			}
			
			if( Integer.parseInt(txtFromDay.getText().trim()) >31)
			{
				JOptionPane.showMessageDialog(frame, "Enter value from 0 to 31");
				txtFromDay.setBackground(Color.YELLOW);
				return;
			}
			
		}

		if(!StringUtils.isEmpty(toDayTxt.getText())){
			if(!isInteger(toDayTxt.getText().trim()))
			{
				JOptionPane.showMessageDialog(frame, "To day must be number");
				toDayTxt.setBackground(Color.YELLOW);
				return;
			}
		}
		
		if(isInteger(toDayTxt.getText().trim()))
		{
			if( Integer.parseInt(toDayTxt.getText().trim()) <=0)
			{
				JOptionPane.showMessageDialog(frame, "Enter value from 0 to 31");
				toDayTxt.setBackground(Color.YELLOW);
				return;
			}
			
			if( Integer.parseInt(toDayTxt.getText().trim()) >31 )
			{
				JOptionPane.showMessageDialog(frame, "Enter value from 0 to 31");
				toDayTxt.setBackground(Color.YELLOW);
				return;
			}
		}
		
		if(!StringUtils.isEmpty(toDayTxt.getText())){
		{
			if( Integer.parseInt(toDayTxt.getText().trim()) < Integer.parseInt(txtFromDay.getText().trim()))
			{
				JOptionPane.showMessageDialog(frame, "To day must larger from day");
				toDayTxt.setBackground(Color.YELLOW);
				return;
			}
		}
		
		
		if(StringUtils.isEmpty(txtValue.getText().trim())){
			JOptionPane.showMessageDialog(frame, "You must enter value");
			txtValue.setBackground(Color.YELLOW);
			return;
		}
		
		if(!isInteger(txtValue.getText().trim()))
		{
			JOptionPane.showMessageDialog(frame, "Value must be number");
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
			int day=Integer.parseInt(txtFromDay.getText().trim());
					
			if(!StringUtils.isEmpty(toDayTxt.getText())){
				day=Integer.parseInt(toDayTxt.getText().trim());
			}
			
			
			boolean update=false;
			for(int i=Integer.parseInt(txtFromDay.getText().trim()) ;i<=day;i++)
			{
				
				//System.out.println(offerId);
				
				checkExistTariff=RCTariffDAO.checkExistTariff(offerId, statusId,i, conn);				
				if(checkExistTariff){
					
					JOptionPane.showMessageDialog(frame, "Tariff is exist. Can not create more rating type with the same subscriber status.");
					break;
					
				}else{
					
					Boolean isExit=RCTariffDAO.checkExistCode(i,offerId,typeId,statusId, conn);
					
					if(!isExit){
						RCTariff rcTariff = new RCTariff(i, offerId,typeId,statusId,Integer.parseInt(txtValue.getText()),chk);
						int result = RCTariffDAO.QuickcreateRCTariff(rcTariff, conn);
						if(result == SUCCESS){
							update=true;
							QuickRCTariffDialog.this.dispose();				
						}else{
							JOptionPane.showMessageDialog(frame, "Configation RC not sucessfull  ");
						}
					}else{
						
						JOptionPane.showMessageDialog(frame, "Exit in database ");
						break;
					  }
					}
				
			 }
		    //Success then refresh
			if (update){
				RCTariffDialog.updateTable();
			}
			conn.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}

	
	

	public void setRowValue(String day, String productname, String typeId,String statusId,String value,Boolean fullcycle){
      	 chkfull.setSelected(fullcycle);
	
	}
}
