package eonerateui.gui.menu.tool;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.RenderingHints;
import java.awt.Stroke;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

import com.toedter.calendar.JDateChooser;
import com.toedter.components.JSpinField;

import eonerateui.controller.xml.xmlParser;
import eonerateui.db.MonitoringDAO;
import eonerateui.util.CodeConstants;
import eonerateui.util.DateUtils;
import eonerateui.util.MessageConstants;
import eonerateui.util.ProgramConfig;

import javax.swing.border.LineBorder;
import javax.swing.JComboBox;
import javax.swing.SwingConstants;

public class PipelineStatistic extends JDialog {
	
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
	private static JComboBox comboPipeline;
	private static JComboBox comboVirtualMachine;
	private JPanel panelBar;
	private PanelStatistic mainPanel;
	private List<Double> scores;
	private JLabel labelTime;
	
	private static PipelineStatistic dialog;


	public PipelineStatistic() throws IOException {
		setModalExclusionType(ModalExclusionType.APPLICATION_EXCLUDE);
		setModalityType(ModalityType.APPLICATION_MODAL);
		setModal(true);
		setTitle("Pipeline statistic");
		setResizable(false);
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 869, 549);
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);

		JPanel panelCondition = new JPanel();
		panelCondition.setBorder(new LineBorder(new Color(192, 192, 192)));
		panelCondition.setBounds(679, 11, 174, 311);
		getContentPane().add(panelCondition);
		panelCondition.setLayout(null);
		
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
		
		JButton btnOK = new JButton("OK");
		btnOK.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					createAndShowGui(false);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		});
		btnOK.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnOK.setBounds(679, 486, 81, 23);
		getContentPane().add(btnOK);
		
		JButton btnClose = new JButton("Close");
		btnClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				PipelineStatistic.this.dispose();
			}
		});
		btnClose.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnClose.setBounds(770, 486, 83, 23);
		getContentPane().add(btnClose);
		
		JPanel panel = new JPanel();
		panel.setBorder(new LineBorder(new Color(192, 192, 192)));
		panel.setBounds(679, 333, 174, 138);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JLabel lblVirtualMachine = new JLabel("Virtual Machine:");
		lblVirtualMachine.setBounds(20, 24, 146, 14);
		lblVirtualMachine.setForeground(new Color(0, 128, 128));
		lblVirtualMachine.setFont(new Font("Tahoma", Font.BOLD, 11));
		panel.add(lblVirtualMachine);
		
		comboVirtualMachine = new JComboBox();
		comboVirtualMachine.setForeground(new Color(160, 82, 45));
		comboVirtualMachine.setFont(new Font("Tahoma", Font.PLAIN, 11));
		comboVirtualMachine.setBounds(20, 44, 146, 20);
		panel.add(comboVirtualMachine);
		
		JLabel lblPipeline = new JLabel("Pipeline:");
		lblPipeline.setForeground(new Color(0, 128, 128));
		lblPipeline.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblPipeline.setBounds(20, 80, 146, 14);
		panel.add(lblPipeline);
		
		comboPipeline = new JComboBox();
		comboPipeline.setForeground(new Color(160, 82, 45));
		comboPipeline.setFont(new Font("Tahoma", Font.PLAIN, 11));
		comboPipeline.setBounds(20, 100, 146, 20);
		panel.add(comboPipeline);
		
		loadData2Combo();

		panelBar = new JPanel();
		panelBar.setBorder(new LineBorder(new Color(192, 192, 192)));
		panelBar.setBounds(10, 11, 659, 498);

       	xmlParser xml = new xmlParser(ProgramConfig.getConfigFile());
        int cdrOfCsv  = Integer.parseInt(xml.getConfig("statistic", "cdrOfCsv"));
		xml=null;
        DecimalFormat df = new DecimalFormat("#,###");
        
        JLabel labelCDR = new JLabel("Total CDR (" + df.format(cdrOfCsv) + ")");
        labelCDR.setHorizontalAlignment(SwingConstants.CENTER);
        labelCDR.setFont(new Font("Tahoma", Font.BOLD, 11));
        labelCDR.setForeground(new Color(0, 128, 128));
        labelCDR.setBounds(7, 11, 120, 14);
        panelBar.add(labelCDR);
        
		labelTime = new JLabel();
        labelTime.setHorizontalAlignment(SwingConstants.CENTER);
        labelTime.setFont(new Font("Tahoma", Font.BOLD, 11));
        labelTime.setForeground(new Color(0, 128, 128));
        labelTime.setBounds(44, 473, 583, 14);
        panelBar.add(labelTime);
        
        getContentPane().add(panelBar);
        panelBar.setLayout(null);
        
        scores = new ArrayList<Double>();
        mainPanel = new PanelStatistic(scores);
        mainPanel.setBounds(7, 25, 645, 448);
        panelBar.add(mainPanel);

		try {
			createAndShowGui(false);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}
	
	private void loadData2Combo() {
		List<String> listCombo;
		
		listCombo = MonitoringDAO.getListOfCombo(CodeConstants.RATING_MONITOR.JVM);
		for (int i=0; i< listCombo.size(); i++) 
			comboVirtualMachine.addItem(listCombo.get(i));
		
		listCombo = MonitoringDAO.getListOfCombo(CodeConstants.RATING_MONITOR.PIPELINE);
		for (int i=0; i< listCombo.size(); i++) 
			comboPipeline.addItem(listCombo.get(i));
}
	
	
    private void createAndShowGui(boolean startGUI) throws IOException {
    	Calendar fromCal = Calendar.getInstance();
    	fromCal.setTime(dateFromDate.getDate());
    	fromCal.set(fromCal.get(Calendar.YEAR), fromCal.get(Calendar.MONTH), fromCal.get(Calendar.DAY_OF_MONTH), spinFromHH.getValue(), spinFromMM.getValue(), spinFromSS.getValue());
    	
    	Calendar toCal = Calendar.getInstance();
    	toCal.setTime(dateToDate.getDate());
    	toCal.set(toCal.get(Calendar.YEAR), toCal.get(Calendar.MONTH), toCal.get(Calendar.DAY_OF_MONTH), spinToHH.getValue(), spinToMM.getValue(), spinToSS.getValue());

    	Date fromDate = fromCal.getTime();
    	Date toDate   = toCal.getTime();
    	
    	if (fromCal.getTimeInMillis()>toCal.getTimeInMillis()) {
    		JOptionPane.showMessageDialog(PipelineStatistic.this, MessageConstants.MONITORING.INVALID_TIME);
    	}
    	else {
    		long diff = Math.abs(toDate.getTime()- fromDate.getTime());
    		int maxDataPoints = (int) diff / (60 * 60 * 1000);

            scores.clear();
     
            if (startGUI) {
                for (int i = 0; i < maxDataPoints; i++) {
                    scores.add((double) 0);
                }
            }
            else {
            	String startTime = DateUtils.getDateStringInformat(fromDate, "ddMMyyyyHHmmss");
            	String endTime = DateUtils.getDateStringInformat(toDate, "ddMMyyyyHHmmss");

     		    long hourStart = fromCal.getTimeInMillis()/ (1000 * 60 * 60);				
    		    
        		HashMap<String, Integer> mapScore = MonitoringDAO.getScoreValueOfPipeline(startTime, endTime, comboVirtualMachine.getSelectedItem().toString(), comboPipeline.getSelectedItem().toString());
                for (int i = 0; i < maxDataPoints; i++) {
        		    String key = Long.toString(hourStart);
                	double scoreValue =0;
                	if (mapScore.containsKey(key)) {
                		scoreValue = (double) mapScore.get(key);
                	}
                	scores.add(scoreValue);
                	hourStart++;
                }
            }

            labelTime.setText("From " + DateUtils.getDateStringInformat(fromDate, "dd/MM/yyyy HH:mm:ss") + " to " + DateUtils.getDateStringInformat(toDate, "dd/MM/yyyy HH:mm:ss") + " have total " + Integer.toString(maxDataPoints) + " hour(s)");
            mainPanel.repaint();
            panelBar.repaint();
    	}
    }
	
    public static void main(String[] args) throws IOException {
    	dialog  = new PipelineStatistic();
        dialog.setVisible(true);
    }
}

class PanelStatistic extends JPanel {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int width = 645;
    private int heigth = 445;
    private int padding = 25;
    private int labelPadding = 25;
    private Color lineColor = new Color(44, 102, 230, 180);
    private Color pointColor = new Color(100, 100, 100, 180);
    private Color gridColor = new Color(200, 200, 200, 200);
    private static final Stroke GRAPH_STROKE = new BasicStroke(2f);
    private int pointWidth = 4;
    private int numberYDivisions = 10;
    private List<Double> scores;

    public PanelStatistic(List<Double> scores) {
        this.scores = scores;
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2 = (Graphics2D) g;
        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        double xScale = ((double) getWidth() - (2 * padding) - labelPadding) / (scores.size() - 1);
        double yScale = ((double) getHeight() - 2 * padding - labelPadding) / (getMaxScore() - getMinScore());

        List<Point> graphPoints = new ArrayList<Point>();
        for (int i = 0; i < scores.size(); i++) {
            int x1 = (int) (i * xScale + padding + labelPadding);
            int y1 = (int) ((getMaxScore() - scores.get(i)) * yScale + padding);
            graphPoints.add(new Point(x1, y1));
        }

        // draw white background
        g2.setColor(Color.WHITE);
        g2.fillRect(padding + labelPadding, padding, getWidth() - (2 * padding) - labelPadding, getHeight() - 2 * padding - labelPadding);
        g2.setColor(Color.BLACK);

        // create hatch marks and grid lines for y axis.
        for (int i = 0; i < numberYDivisions + 1; i++) {
            int x0 = padding + labelPadding;
            int x1 = pointWidth + padding + labelPadding;
            int y0 = getHeight() - ((i * (getHeight() - padding * 2 - labelPadding)) / numberYDivisions + padding + labelPadding);
            int y1 = y0;
            if (scores.size() > 0) {
                g2.setColor(gridColor);
                g2.drawLine(padding + labelPadding + 1 + pointWidth, y0, getWidth() - padding, y1);
                g2.setColor(Color.BLACK);
                String yLabel = ((int) ((getMinScore() + (getMaxScore() - getMinScore()) * ((i * 1.0) / numberYDivisions)) * 100)) / 100.0 + "";
                FontMetrics metrics = g2.getFontMetrics();
                int labelWidth = metrics.stringWidth(yLabel);
                g2.drawString(yLabel, x0 - labelWidth - 5, y0 + (metrics.getHeight() / 2) - 3);
            }
            g2.drawLine(x0, y0, x1, y1);
        }

        // and for x axis
        for (int i = 0; i < scores.size(); i++) {
            if (scores.size() > 1) {
                int x0 = i * (getWidth() - padding * 2 - labelPadding) / (scores.size() - 1) + padding + labelPadding;
                int x1 = x0;
                int y0 = getHeight() - padding - labelPadding;
                int y1 = y0 - pointWidth;
                if ((i % ((int) ((scores.size() / 20.0)) + 1)) == 0) {
                    g2.setColor(gridColor);
                    g2.drawLine(x0, getHeight() - padding - labelPadding - 1 - pointWidth, x1, padding);
                    g2.setColor(Color.BLACK);
                    String xLabel = i + "";
                    FontMetrics metrics = g2.getFontMetrics();
                    int labelWidth = metrics.stringWidth(xLabel);
                    g2.drawString(xLabel, x0 - labelWidth / 2, y0 + metrics.getHeight() + 3);
                }
                g2.drawLine(x0, y0, x1, y1);
            }
        }

        // create x and y axes 
        g2.drawLine(padding + labelPadding, getHeight() - padding - labelPadding, padding + labelPadding, padding);
        g2.drawLine(padding + labelPadding, getHeight() - padding - labelPadding, getWidth() - padding, getHeight() - padding - labelPadding);

        Stroke oldStroke = g2.getStroke();
        g2.setColor(lineColor);
        g2.setStroke(GRAPH_STROKE);
        for (int i = 0; i < graphPoints.size() - 1; i++) {
            int x1 = graphPoints.get(i).x;
            int y1 = graphPoints.get(i).y;
            int x2 = graphPoints.get(i + 1).x;
            int y2 = graphPoints.get(i + 1).y;
            g2.drawLine(x1, y1, x2, y2);
        }

        g2.setStroke(oldStroke);
        g2.setColor(pointColor);
        for (int i = 0; i < graphPoints.size(); i++) {
            int x = graphPoints.get(i).x - pointWidth / 2;
            int y = graphPoints.get(i).y - pointWidth / 2;
            int ovalW = pointWidth;
            int ovalH = pointWidth;
            g2.fillOval(x, y, ovalW, ovalH);
        }
    }

    @Override
    public Dimension getPreferredSize() {
        return new Dimension(width, heigth);
    }
    
    private double getMinScore() {
        double minScore = Double.MAX_VALUE;
        for (Double score : scores) {
            minScore = Math.min(minScore, score);
        }
        return minScore;
    }

    private double getMaxScore() {
        double maxScore = Double.MIN_VALUE;
        for (Double score : scores) {
            maxScore = Math.max(maxScore, score);
        }
        return maxScore;
    }

    public void setScores(List<Double> scores) {
        this.scores = scores;
        invalidate();
        this.repaint();
    }

    public List<Double> getScores() {
        return scores;
    }

}