package eonerateui.gui.menu.rating;

import java.awt.Color;
import java.awt.Font;
import java.awt.SystemColor;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;

import javax.swing.ButtonGroup;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.ScrollPaneConstants;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;

import eonerateui.controller.rc_rating.RC_Process;
import eonerateui.controller.xml.xmlParser;
import eonerateui.gui.main.MainApplicationUI;
import eonerateui.util.CodeConstants;
import eonerateui.util.MessageConstants;
import eonerateui.util.ProgramConfig;

@SuppressWarnings("serial")
public class RC_Rating extends JDialog {
	
	private final ButtonGroup buttonGroupType = new ButtonGroup();
	private final ButtonGroup buttonGroupOput = new ButtonGroup();
	private JRadioButton radioAllsub;
	private JRadioButton radioChangePO;
	private JComboBox comboMonth;
	private JComboBox comboYear;
	public static JProgressBar progressRC;
	public static JTextArea txtareLog;
	private JCheckBox checkUsage;
	private JRadioButton radioInsert;
	private JRadioButton radioLoad;
	private JLabel lblMonth;
	private JLabel lblYear;
	private final JButton buttonOK; 
	
	private Thread threadRC;
	private boolean inBackground;
	private static boolean doneRating = true;
	private boolean isScheduleMode = false;
	private static RC_Process rc;

	/**
	 * Launch the application.
	 */
	
	public static void setProgressValue(int value) {
		progressRC.setValue(value);
		MainApplicationUI.setProgressValue(value);
	}
	
	public static void setIndeterminate(boolean b) {
		progressRC.setIndeterminate(b);
		progressRC.setStringPainted(!b);
		MainApplicationUI.setIndeterminate(b);
	}
	
	public static void setProgressMax(int max) {
		progressRC.setMaximum(max);
		MainApplicationUI.setProgressMax(max);
	}
	
	public static Boolean isRunning(){
		if (rc!=null) 
			doneRating = rc.isDoneRating();
		else
			doneRating = true;
		
		boolean returnValue = (txtareLog.getText().length()>0) && !doneRating;
		
		return returnValue;
	}
	
	public static void setStatus(String s) {
		txtareLog.append(s + "\n");
		txtareLog.setCaretPosition(txtareLog.getDocument().getLength());
		MainApplicationUI.setStatus(s);
	}
	
	public static void clearStatus() {
		txtareLog.setText("");
		MainApplicationUI.clearStatus();
	}

	private void setWaiting(boolean b) {
		radioAllsub.setEnabled(!b);
		radioChangePO.setEnabled(!b);
		radioInsert.setEnabled(!b);
		radioLoad.setEnabled(!b);
		comboMonth.setEnabled(!b);
		comboYear.setEnabled(!b);
//		checkPO.setEnabled(!b);
		checkUsage.setEnabled(!b);
//		checkVAS.setEnabled(!b);
		lblMonth.setEnabled(!b);
		lblYear.setEnabled(!b);
		
		if (!progressRC.isVisible()) progressRC.setVisible(b);
		
		if (b) buttonOK.setText("Hide"); 
		else   buttonOK.setText("OK");
		
		RC_Rating.this.setVisible(!inBackground);
	}
	

	private boolean isValidBillCycle() {
		Calendar cld = Calendar.getInstance();
		int timeSelect = Integer.parseInt(comboYear.getSelectedItem().toString()) * 12 + Integer.parseInt(comboMonth.getSelectedItem().toString());
		int now 	   = cld.get(Calendar.YEAR) * 12 + (cld.get(Calendar.MONTH)+1);
		
		return (timeSelect <= now);
	}			

	/**
	 * Create the dialog.
	 */
	@SuppressWarnings({ "static-access" })
	public RC_Rating() {
		setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);
		setModalityType(ModalityType.APPLICATION_MODAL);
		setResizable(false);
		setModal(true);
		setTitle("Recurrring charge rating");
		setAlwaysOnTop(false);
		setBounds(350, 100, 482, 473);
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
//		try {
//			UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
//		} catch(Exception e){
//			e.printStackTrace();
//		}
		RC_Rating.setDefaultLookAndFeelDecorated(true);
		{
			JPanel pnlSubType = new JPanel();
			pnlSubType.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Subscriber type", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
			pnlSubType.setBounds(10, 11, 229, 97);
			getContentPane().add(pnlSubType);
			pnlSubType.setLayout(null);

			radioAllsub = new JRadioButton("All subscribers of cycle");
			radioAllsub.setFont(new Font("Tahoma", Font.PLAIN, 11));
			radioAllsub.setBounds(24, 30, 179, 23);
			pnlSubType.add(radioAllsub);
		
			radioChangePO = new JRadioButton("Changed PO subscribers");
			radioChangePO.setFont(new Font("Tahoma", Font.PLAIN, 11));
			radioChangePO.setBounds(24, 57, 179, 23);
			pnlSubType.add(radioChangePO);

			buttonGroupType.add(radioAllsub);
			buttonGroupType.add(radioChangePO);			
			radioAllsub.setSelected(true);
		}
		{
			JPanel pnlBillcyle = new JPanel();
			pnlBillcyle.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Billing cycle", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
			pnlBillcyle.setBounds(249, 11, 217, 97);
			getContentPane().add(pnlBillcyle);
			pnlBillcyle.setLayout(null);

			lblMonth = new JLabel("Month");
			lblMonth.setFont(new Font("Tahoma", Font.PLAIN, 11));
			lblMonth.setBounds(30, 36, 48, 14);
			pnlBillcyle.add(lblMonth);
			
			comboMonth = new JComboBox();
			comboMonth.setFont(new Font("Tahoma", Font.PLAIN, 11));
			comboMonth.setModel(new DefaultComboBoxModel(new String[] {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"}));
			comboMonth.setBounds(89, 30, 85, 20);
			pnlBillcyle.add(comboMonth);

			lblYear = new JLabel("Year"); //$NON-NLS-1$ //$NON-NLS-2$
			lblYear.setFont(new Font("Tahoma", Font.PLAIN, 11));
			lblYear.setBounds(30, 61, 48, 14);
			pnlBillcyle.add(lblYear);

			comboYear = new JComboBox();
			comboYear.setFont(new Font("Tahoma", Font.PLAIN, 11));
			comboYear.setModel(new DefaultComboBoxModel(new String[] {"2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035", "2036", "2037", "2038", "2039", "2040", "2041", "2042", "2043", "2044", "2045", "2046", "2047", "2048", "2049", "2050"}));
			comboYear.setBounds(89, 55, 85, 20);
			pnlBillcyle.add(comboYear);	
			
			Calendar currentDate = Calendar.getInstance();		
			comboMonth.setSelectedItem(Integer.toString(currentDate.get(currentDate.MONTH)+1));
			comboYear.setSelectedItem(Integer.toString(currentDate.get(currentDate.YEAR)));
		}
		{
			JPanel pnlUsage = new JPanel();
			pnlUsage.setLayout(null);
			pnlUsage.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "RC rating type", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
			pnlUsage.setBounds(10, 119, 456, 71);
			getContentPane().add(pnlUsage);
			
			checkUsage = new JCheckBox("Recurring charge rating of POs and Services will rate for full cycle"); //$NON-NLS-1$ //$NON-NLS-2$
			checkUsage.setFont(new Font("Tahoma", Font.PLAIN, 11));
			checkUsage.setSelected(true);
			checkUsage.setBounds(28, 28, 410, 23);
			pnlUsage.add(checkUsage);
		}
		{
			JPanel panelOutput = new JPanel();
			panelOutput.setLayout(null);
			panelOutput.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Load result method", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
			panelOutput.setBounds(10, 205, 456, 71);
			getContentPane().add(panelOutput);
			
			radioInsert = new JRadioButton("Using bulk insert into Oracle");
			radioInsert.setFont(new Font("Tahoma", Font.PLAIN, 11));
			radioInsert.setBounds(30, 30, 188, 23);
			panelOutput.add(radioInsert);
			
			radioLoad = new JRadioButton("Using SQL loader from CSV"); //$NON-NLS-1$ //$NON-NLS-2$
			radioLoad.setSelected(true);
			radioLoad.setFont(new Font("Tahoma", Font.PLAIN, 11));
			radioLoad.setBounds(248, 30, 183, 23);
			panelOutput.add(radioLoad);
			
			buttonGroupOput.add(radioInsert);
			buttonGroupOput.add(radioLoad);
		}
		{
			JPanel pnlStatus = new JPanel();
			pnlStatus.setLayout(null);
			pnlStatus.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Rating information", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
			pnlStatus.setBounds(10, 280, 456, 118);
			getContentPane().add(pnlStatus);
			
			txtareLog = new JTextArea();
			txtareLog.setLineWrap(true);
			txtareLog.setWrapStyleWord(true);
			txtareLog.setForeground(new Color(0, 100, 0));
			txtareLog.setFont(new Font("Tahoma", Font.PLAIN, 11));
			txtareLog.setEditable(false);
			txtareLog.setText("");
			txtareLog.setBounds(31, 21, 371, 86);
			pnlStatus.add(txtareLog);
			
	        
			JScrollPane scrollText = new JScrollPane(txtareLog);
			scrollText.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
			scrollText.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
			pnlStatus.add(scrollText);
			scrollText.setBounds(12, 20, 434, 86);
			
		}		
		{
			progressRC = new JProgressBar();
			progressRC.setIndeterminate(true);
			progressRC.setForeground(SystemColor.textHighlight);
			progressRC.setStringPainted(true);
			progressRC.setBounds(10, 409, 304, 25);
			progressRC.setVisible(false);
			getContentPane().add(progressRC);
		}
		buttonOK = new JButton("OK"); //$NON-NLS-1$ //$NON-NLS-2$
		buttonOK.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					doRating();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
		});
		buttonOK.setFont(new Font("Tahoma", Font.PLAIN, 11));
		buttonOK.setActionCommand("OK");
		buttonOK.setBounds(324, 409, 65, 25);
		getContentPane().add(buttonOK);

		JButton buttonCancel = new JButton("Close"); //$NON-NLS-1$ //$NON-NLS-2$
		buttonCancel.setFont(new Font("Tahoma", Font.PLAIN, 11));
		buttonCancel.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (!isRunning()) {
					try {
						closeRC();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				else {
					JOptionPane.showMessageDialog(RC_Rating.this, MessageConstants.RC_RATING.CAN_NOT_STOP, "RC Rating", JOptionPane.WARNING_MESSAGE);
				}
			}
		});
		buttonCancel.setActionCommand("Cancel");
		buttonCancel.setBounds(399, 409, 67, 25);
		getContentPane().add(buttonCancel);
		
		MainApplicationUI.setShowDetailRC(true);
	}
	
	private void doRating() throws SQLException {
		if (!isRunning() && !isScheduleMode) 
//			if (checkPO.isSelected() || checkVAS.isSelected())
//			{
				//Check validation of billing cycle, if bill month > current time then invalid
				if (isValidBillCycle()) 
				{					
					doneRating = false;
					threadRC = new Thread() {
						public void run() {
							int rateChoice =-1;
					        try {
								//Start rate RC
								int packageSelected=0;
//								if (checkPO.isSelected() && checkVAS.isSelected()) 
//									packageSelected = 0;
//								else if (checkPO.isSelected())
//									packageSelected = 1;
//								else
//									packageSelected = 2;

								xmlParser xml = new xmlParser(ProgramConfig.getConfigFile());
					        	inBackground = (Integer.parseInt(xml.getConfig("runMode", "inBackground")) == CodeConstants.RC_RATING.RUN_BACKGROUND);
					        	xml=null;
					        	
								if (inBackground)
									JOptionPane.showMessageDialog(RC_Rating.this, MessageConstants.RC_RATING.RUN_IN_BACKGROUND);
									
								
								rateChoice = JOptionPane.showOptionDialog(RC_Rating.this, MessageConstants.RC_RATING.IMMEDIATELY_OR_SCHEDULE, "RC Rating", 
										JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.INFORMATION_MESSAGE, null, new Object[]{"Rate now", "Schedule", "Cancel"}, "default");
								if (rateChoice==0) 
								{
									setWaiting(true);
									rc = new RC_Process(radioAllsub.isSelected(), Integer.parseInt(comboMonth.getSelectedItem().toString()), Integer.parseInt(comboYear.getSelectedItem().toString()), checkUsage.isSelected(), packageSelected, radioInsert.isSelected());
									rc.rateRC();
									setWaiting(false);
									buttonOK.setEnabled(false);
									rc.close();	
									rc = null;
								}
								else {
									if (rateChoice==1) {
										setWaiting(true);
										isScheduleMode = true;
										rc = new RC_Process(radioAllsub.isSelected(), Integer.parseInt(comboMonth.getSelectedItem().toString()), Integer.parseInt(comboYear.getSelectedItem().toString()), checkUsage.isSelected(), packageSelected, radioInsert.isSelected());
										rc.rateScheduleRC();
										doneRating = rc.isDoneRating();
									}
								}
					        } catch (SQLException e) {
								e.printStackTrace();
							} catch (NumberFormatException e) {
								e.printStackTrace();
							} catch (IOException e) {
								e.printStackTrace();
							} catch (ParseException e) {
								e.printStackTrace();
							}
					        finally {
					        	if (rateChoice==0) {
						        	try {
										if (rc!=null) rc.close();
										doneRating = true;
									} catch (SQLException e) {
										e.printStackTrace();
									}	
									rc = null;
									threadRC=null;
					        	}
					        }
					      }
					};

					threadRC.start();
					
				}
				else {
					if (JOptionPane.showOptionDialog(RC_Rating.this, MessageConstants.RC_RATING.NO_RATE_FUTURE, "Feedback", 
							JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE, null, new String[]{"Reselect cycle", "Close"}, "default") ==1) 
						closeRC();
				}	
//			}
//			else {
//				if (JOptionPane.showOptionDialog(RC_Rating.this, MessageConstants.RC_RATING.NEED_PRODUCT_OFFER, "Feedback", 
//						JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE, null, new String[]{"Reselect cycle", "Close"}, "default") ==1) 
//					closeRC();
//			}
		else {
			RC_Rating.this.setVisible(false);
		}

	}
	
	@SuppressWarnings("deprecation")
	private void closeRC() throws SQLException {
		if (threadRC != null) {
			threadRC.stop();
		}

		if (rc!=null) {
			rc.close();
			rc.releaseTimerSchedule();
			rc=null;
		}

		RC_Rating.this.dispose();

		MainApplicationUI.setShowDetailRC(false);
		MainApplicationUI.setIndeterminate(false);
		MainApplicationUI.setProgressValue(0);
		MainApplicationUI.setCloseRC();
	}
}
	

