package eonerateui.gui.menu.tool;


import java.awt.Color;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.Map.Entry;

import javafx.application.Platform;
import javafx.embed.swing.JFXPanel;
import javafx.scene.Scene;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;

import com.toedter.calendar.JDateChooser;
import com.toedter.components.JSpinField;

import eonerateui.controller.xml.xmlParser;
import eonerateui.db.MonitoringDAO;
import eonerateui.util.DateUtils;
import eonerateui.util.ProgramConfig;

public class PipelineMonitoring extends JDialog {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static JDateChooser dateFromDate;
	private static JDateChooser dateToDate;
	private static JSpinField spinFromHH;
	private static JSpinField spinFromMM;
	private static JSpinField spinFromSS;
	private static JSpinField spinToHH;
	private static JSpinField spinToMM;
	private static JSpinField spinToSS;
	private static JPanel panelBar;
	private static JFXPanel fxPanel;
	
	private static PipelineMonitoring dialog;

	public PipelineMonitoring() {
		setModalExclusionType(ModalExclusionType.APPLICATION_EXCLUDE);
		setModalityType(ModalityType.APPLICATION_MODAL);
		setModal(true);
		setTitle("VM and Pipeline Monitoring");
		setResizable(false);
		//setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 782, 549);
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		
		JPanel panelCondition = new JPanel();
		panelCondition.setBounds(604, 11, 162, 488);
		getContentPane().add(panelCondition);
		panelCondition.setLayout(null);
		
		JButton btnOK = new JButton("OK");
		btnOK.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				initAndShowGUI();
			}
		});
		btnOK.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnOK.setBounds(13, 465, 70, 23);
		panelCondition.add(btnOK);
		
		JButton btnClose = new JButton("Close");
		btnClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				PipelineMonitoring.this.setVisible(false);
			}
		});
		btnClose.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnClose.setBounds(90, 465, 71, 23);
		panelCondition.add(btnClose);
		
		JLabel labelFromDate = new JLabel("From date (mon, d, yyyy):");
		labelFromDate.setForeground(new Color(0, 128, 128));
		labelFromDate.setFont(new Font("Tahoma", Font.BOLD, 11));
		labelFromDate.setBounds(17, 31, 148, 14);
		panelCondition.add(labelFromDate);
		
		JLabel labelFromTime = new JLabel("From time (h24, m, s):");
		labelFromTime.setForeground(new Color(0, 128, 128));
		labelFromTime.setFont(new Font("Tahoma", Font.BOLD, 11));
		labelFromTime.setBounds(17, 87, 147, 14);
		panelCondition.add(labelFromTime);

		Calendar startCal = Calendar.getInstance();
		startCal.set(startCal.get(Calendar.YEAR), startCal.get(Calendar.MONTH), 1);
		Date startDate = startCal.getTime();
		
		dateFromDate = new JDateChooser();
		dateFromDate.setBounds(17, 51, 144, 20);
		panelCondition.add(dateFromDate);
		dateFromDate.setDate(startDate);
		
		spinFromHH = new JSpinField();
		spinFromHH.setBounds(17, 107, 43, 20);
		spinFromHH.setMaximum(23);
		spinFromHH.setMinimum(0);
		spinFromHH.setValue(0);
		panelCondition.add(spinFromHH);

		spinFromMM = new JSpinField();
		spinFromMM.setBounds(67, 107, 43, 20);
		spinFromMM.setMaximum(59);
		spinFromMM.setMinimum(0);
		spinFromMM.setValue(0);
		panelCondition.add(spinFromMM);

		spinFromSS = new JSpinField();
		spinFromSS.setBounds(117, 107, 43, 20);
		spinFromSS.setMaximum(59);
		spinFromSS.setMinimum(0);
		spinFromSS.setValue(1);
		panelCondition.add(spinFromSS);

		JLabel labelToDate = new JLabel("To date (mon, d, yyyy):");
		labelToDate.setForeground(new Color(0, 128, 128));
		labelToDate.setFont(new Font("Tahoma", Font.BOLD, 11));
		labelToDate.setBounds(17, 194, 144, 14);
		panelCondition.add(labelToDate);
		
		Calendar cal = Calendar.getInstance();

		dateToDate = new JDateChooser();
		dateToDate.setBounds(17, 214, 144, 20);
		panelCondition.add(dateToDate);
		dateToDate.setDate(cal.getTime());
		
		JLabel labelToTime = new JLabel("To time (h24, m, s):");
		labelToTime.setForeground(new Color(0, 128, 128));
		labelToTime.setFont(new Font("Tahoma", Font.BOLD, 11));
		labelToTime.setBounds(17, 250, 144, 14);
		panelCondition.add(labelToTime);

		spinToHH = new JSpinField();
		spinToHH.setBounds(17, 270, 43, 20);
		spinToHH.setMaximum(23);
		spinToHH.setMinimum(0);
		spinToHH.setValue(cal.get(Calendar.HOUR_OF_DAY));
		panelCondition.add(spinToHH);

		spinToMM = new JSpinField();
		spinToMM.setBounds(67, 270, 43, 20);
		spinToMM.setMaximum(59);
		spinToMM.setMinimum(0);
		spinToMM.setValue(cal.get(Calendar.MINUTE));
		panelCondition.add(spinToMM);

		spinToSS = new JSpinField();
		spinToSS.setBounds(117, 270, 43, 20);
		spinToSS.setMaximum(59);
		spinToSS.setMinimum(0);
		spinToSS.setValue(cal.get(Calendar.SECOND));
		panelCondition.add(spinToSS);
		
		panelBar = new JPanel();
		panelBar.setBounds(10, 11, 595, 488);
		getContentPane().add(panelBar);
		
		fxPanel = new JFXPanel();
		panelBar.add(fxPanel);
		
		initAndShowGUI();
	}

	private static void initAndShowGUI() {
		Platform.runLater(new Runnable() {
			@Override
			public void run() {
		        Scene scene;
				try {
					scene = createScene();
			        fxPanel.setScene(scene);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static Scene createScene() throws IOException {
        CategoryAxis xAxis = new CategoryAxis();
	    NumberAxis yAxis = new NumberAxis();
	    BarChart<String,Number> bc = new BarChart<String,Number>(xAxis,yAxis);
	    bc.setTitle("VM and Pipeline of rating statistic");
	    xAxis.setLabel("VM/Pipeline");       
	    yAxis.setLabel("CDR");

	    xmlParser xml = new xmlParser(ProgramConfig.getConfigFile());
		int csvSize	  = Integer.parseInt(xml.getConfig("statistic", "cdrOfCsv"));
		xml=null;

		Map<String, Map<String, Integer>> mapCSVInfor = statisticData();
	    XYChart.Series[] series = new XYChart.Series[mapCSVInfor.size()];
	    

		int i =0;
		for (Entry<String, Map<String, Integer>> entryCSV : mapCSVInfor.entrySet()) {
		    series[i] =  new XYChart.Series();
		    series[i].setName("VM-" + entryCSV.getKey());     
		    
		    for (Entry<String, Integer> entryPipelineCdr : entryCSV.getValue().entrySet()) {
			    series[i].getData().add(new XYChart.Data("Pipeline-" + entryPipelineCdr.getKey(), entryPipelineCdr.getValue() * csvSize));
		    }
		    bc.getData().add(series[i]);
		    
		    i++;
		}

	    Scene  scene  =  new  Scene(bc, 600, 480);
	    return (scene);
    }
    
    public static void main(String[] args) {
		dialog = new PipelineMonitoring();
		dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		dialog.setVisible(true);
    }
    
    private static Map<String, Map<String, Integer>> statisticData() {
		String fromDate = DateUtils.getDateStringInformat(dateFromDate.getDate(), "dd/MM/yyyy");
		String fromTime = Integer.toString(spinFromHH.getValue()) + ":" + Integer.toString(spinFromMM.getValue()) + ":" + Integer.toString(spinFromSS.getValue());
		String fromDateTime = fromDate + " " + fromTime;
		
		String toDate = DateUtils.getDateStringInformat(dateToDate.getDate(), "dd/MM/yyyy");
		String toTime = Integer.toString(spinToHH.getValue()) + ":" + Integer.toString(spinToMM.getValue()) + ":" + Integer.toString(spinToSS.getValue());
		String toDateTime = toDate + " " + toTime;

		Map<String, Map<String, Integer>> mapCSVInfor = MonitoringDAO.getInforCSV(fromDateTime, toDateTime);
		
		return mapCSVInfor;
    }
}



