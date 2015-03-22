package eonerateui.gui.main;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Cursor;
import java.awt.EventQueue;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JCheckBoxMenuItem;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JScrollPane;
import javax.swing.JSeparator;
import javax.swing.JTextArea;
import javax.swing.JToolBar;
import javax.swing.ScrollPaneConstants;
import javax.swing.SwingWorker;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;
import javax.swing.table.DefaultTableCellRenderer;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import eci.services.TestWS;
import eonerateui.controller.main.MainProcessor;
import eonerateui.gui.menu.configuration.DBConfigDialog;
import eonerateui.gui.menu.configuration.PipelineConfigDialog;
import eonerateui.gui.menu.configuration.ProcessConfigDialog;
import eonerateui.gui.menu.configuration.RCTariffDialog;
import eonerateui.gui.menu.configuration.RC_ConfigDialog;
import eonerateui.gui.menu.configuration.RatingUsageConfigDialog;
import eonerateui.gui.menu.help.About;
import eonerateui.gui.menu.rating.RC_Rating;
import eonerateui.gui.menu.system.LoginDialog;
import eonerateui.gui.menu.tool.ChangePasswordDialog;
import eonerateui.gui.menu.tool.LogManagementDialog;
import eonerateui.gui.menu.tool.PipelineMonitoring;
import eonerateui.gui.menu.tool.PipelineStatistic;
import eonerateui.gui.menu.tool.UserManagementDialog;
import eonerateui.gui.util.MySortedJTable;
import eonerateui.gui.util.MyTableModel;
import eonerateui.gui.util.ShowLoaderLog;
import eonerateui.util.DateUtils;
import eonerateui.util.IConstant;
import eonerateui.util.MessageConstants;

public class MainApplicationUI {
	private static Logger logger = Logger.getLogger("MainApplicationUI");
	private DBConfigDialog dbConfigForm;
	public static LoginDialog loginForm = new LoginDialog();
	private PipelineConfigDialog pipelineConfigForm;
	private RatingUsageConfigDialog ratingUsageConfigDialog;
	private ProcessConfigDialog processConfigForm;
	private RCTariffDialog rcTariffDialog;
	private static JFrame frmOpenrateUi;
	private static JMenu ratingMenu;
	private static JButton btnInputAdapter;
	private static JButton btnProcessConfig;
	private static JButton btnPipeline;
	private static JButton btnDbConfig;
	private static JMenuItem loginMenuItem;
	private static JMenuItem databaseSubMenuItem;
	private static JMenuItem pipelineSubmenuItem;
	private static JMenuItem processSubmenuItem;
	private static JMenuItem mntmQunLTham;
	private static JMenuItem usageRatingMenuItem;
	private JMenuItem exitMenuItem;
	private static JToolBar toolBar;
	private static JMenu queryMenu;
	//private JMenuItem subscribersMenuItem;
	//private static JButton btnQuerySubscriber;
	private static JButton btnLogManagement;
	private static JButton btnUserManagement;
	private static JButton btnChangePassword;
	private static JButton btnPipelineMonitor;
	private static JButton btnPipelineStatistic;
	//private static SubscribersSearchDialog subscriberSearchDialog;
	private static LogManagementDialog logManagementDialog;
	public static ChangePasswordDialog changePasswordDialog;
	private static UserManagementDialog userManagementDialog;
	private static PipelineMonitoring pipelineMonitoring;
	private static PipelineStatistic pipelineStatistic;
	public static RC_Rating rcRating;
	public static RC_ConfigDialog rcConfig;
	private JPanel rcPanel;
	private static JTextArea rcTextArea;
	private JScrollPane scrollStatus;
	private static JProgressBar rcProgressBar;
	private JLabel lblRcStatus;
	@SuppressWarnings("rawtypes")
	private static SwingWorker worker;
	private JScrollPane scrollTime;
	private static JTextArea textLogTime;
	private static JButton btnRCDetail;
	private static JLabel lblTimestoday;
	private static JButton btnStart;
	private static JButton btnStop;
	private static Boolean eciIsRunning;
	private static String startedFrom;
	private static String stopedAt;
	private static JLabel lblEciStatus;
	private static JButton btnRcRatingConfig;
	private static JButton btnRcTariffConfig;
	private static JButton btnRcRating;
	private static JMenuItem rcConfigMenuItem;
	private static JTextArea eciLogArea;
	private static List<String> logArray = new ArrayList<String>();
	private static int sizeOfLog = 0;
	private static int sizeTemp = 0;
	private JPanel panelSummary;
	private static JMenuItem logManagementMenuItem;
	private static JButton btnRefresh;
	private static JButton btnShowLogRC;
	private static JButton btnShowBadRC;
	private static JButton btnClearLog;
	private static MyTableModel tableModel;
	private static MySortedJTable tableInfo;
	private static MyTableModel csvFileTableModel;
	protected static MainApplicationUI window;

	private static String[] columnNames = { "Summary information", "Values" };
	private static String[] csvFileColumnNames = { "CSV File", "Status", "Created Time", "Last ChangedTime", "Bad File" };
	public static boolean aggDispatchDoing = false;
	private JMenuItem changePasswordMenuItem;
	private JCheckBoxMenuItem chckbxmntmTingVit;
	private JCheckBoxMenuItem chckbxmntmEnglish;
	private static JMenuItem rcTariffConfig;
	private static JMenuItem pipelineMonitoringMenuItem;
	private static JMenuItem pipelineStatisticMenuItem;
	private static JMenuItem userManagementMenuItem;
	public static String username;
	private static JMenu mnConfiguration;
	private static TestWS testWs = new TestWS();

	//private static 
	public static void main(String args[]) {
		EventQueue.invokeLater(new Runnable() {
			@SuppressWarnings("static-access")
			public void run() {
				try {
					window = new MainApplicationUI();
					window.frmOpenrateUi.setVisible(true);
				} catch (Exception e) {
					logger.error("Exception", e);
				}
			}
		});
	}

	/**
	 * Create the application.
	 * 
	 * @throws IOException
	 * @throws SQLException
	 */
	public MainApplicationUI() throws SQLException, IOException {
		initialize();
	}

	public void init() {
		frmOpenrateUi.setVisible(true);
	}

	/**
	 * Initialize the contents of the frame.
	 * 
	 * @throws IOException
	 * @throws SQLException
	 */
	private void initialize() throws SQLException, IOException {
		try {
			MainProcessor.loadProperties();
			UIManager.setLookAndFeel(MainProcessor.look_and_feel);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
		JFrame.setDefaultLookAndFeelDecorated(true);

		frmOpenrateUi = new JFrame();
		frmOpenrateUi.setTitle("eOneRate UI");
		frmOpenrateUi.setBounds(100, 100, 1500, 1000);
		frmOpenrateUi.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		frmOpenrateUi.setExtendedState(frmOpenrateUi.getExtendedState() | JFrame.MAXIMIZED_BOTH);

		frmOpenrateUi.addWindowListener(new java.awt.event.WindowAdapter() {
			@Override
			public void windowClosing(java.awt.event.WindowEvent windowEvent) {

				if (isRunning()) {
					JOptionPane.showMessageDialog(frmOpenrateUi, MessageConstants.MAIN_FORM.WARNING_PROGRAM_IS_RUNNING, "Warning", JOptionPane.WARNING_MESSAGE);
					return;
				}
				int dialogResult = JOptionPane.showConfirmDialog(frmOpenrateUi, MessageConstants.MAIN_FORM.ASK_FOR_EXIT, "Confirmation", JOptionPane.YES_NO_OPTION);
				if (dialogResult == JOptionPane.YES_OPTION) {
					if (worker != null) {
						worker.cancel(true);
					}
					System.exit(0);
				} else {
					return;
				}
			}
		});

		JMenuBar menuBar = new JMenuBar();
		menuBar.setForeground(new Color(0, 0, 0));

		JMenu systemMenu = new JMenu("System");
		systemMenu.setMnemonic(KeyEvent.VK_H);
		menuBar.add(systemMenu);

		/*
		 * add login submenu item
		 */
		loginMenuItem = new JMenuItem("Login");
		loginMenuItem.setIcon(new ImageIcon("./images/login.png"));
		loginMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (!loginForm.getIsLogin()) {
					if (loginForm == null) {
						loginForm = new LoginDialog();
					}
					loginForm.setVisible(true);
				} else {
					try {
						logout();
					} catch (SQLException e) {
						logger.error("SQLException", e);
					} catch (IOException e) {
						logger.error("IOException", e);
					}
				}
			}
		});
		systemMenu.add(loginMenuItem);

		/*
		 * add rc rating config menu
		 */

		/*
		 * add usage rating config menu
		 */

		/*
		 * add database config menu
		 */

		/*
		 * add pipepline config menu
		 */

		/*
		 * add process config menu
		 */

		exitMenuItem = new JMenuItem("Exit");
		exitMenuItem.setIcon(new ImageIcon("./images/logout.png"));
		exitMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int dialogResult = JOptionPane.showConfirmDialog(frmOpenrateUi, MessageConstants.MAIN_FORM.ASK_FOR_EXIT, "Confirmation", JOptionPane.YES_NO_OPTION);
				if (dialogResult == JOptionPane.YES_OPTION) {
					if (worker != null) {
						worker.cancel(true);
					}
					System.exit(0);
				} else {
					return;
				}
			}
		});
		systemMenu.add(exitMenuItem);

		mnConfiguration = new JMenu("Configuration");
		mnConfiguration.setEnabled(false);
		menuBar.add(mnConfiguration);

		rcConfigMenuItem = new JMenuItem("RC Rating Config");
		mnConfiguration.add(rcConfigMenuItem);
		rcConfigMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (rcConfig == null) {
					try {
						rcConfig = new RC_ConfigDialog();
					} catch (IOException e) {
						logger.error("IOException", e);
					}
				}
				rcConfig.setVisible(true);
			}
		});
		rcConfigMenuItem.setIcon(new ImageIcon("./images/rc_rating_config.png"));
		rcConfigMenuItem.setEnabled(false);

		rcTariffConfig = new JMenuItem("RC Tariff Config");
		rcTariffConfig.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (rcTariffDialog == null) {
					rcTariffDialog = new RCTariffDialog();
				}
				rcTariffDialog.setVisible(true);
			}
		});
		rcTariffConfig.setEnabled(false);
		rcTariffConfig.setIcon(new ImageIcon("./images/tariff.png"));
		mnConfiguration.add(rcTariffConfig);

		usageRatingMenuItem = new JMenuItem("Usage Rating Config");
		mnConfiguration.add(usageRatingMenuItem);
		usageRatingMenuItem.setEnabled(true);
		usageRatingMenuItem.setVisible(true);
		usageRatingMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (ratingUsageConfigDialog == null) {
					ratingUsageConfigDialog = new RatingUsageConfigDialog();
				}
				ratingUsageConfigDialog.init();
				ratingUsageConfigDialog.setVisible(true);
			}
		});
		usageRatingMenuItem.setEnabled(false);
		usageRatingMenuItem.setIcon(new ImageIcon("./images/usage_rating.png"));
		databaseSubMenuItem = new JMenuItem("Database Config");
		mnConfiguration.add(databaseSubMenuItem);
		databaseSubMenuItem.setEnabled(false);
		databaseSubMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (dbConfigForm == null) {
					dbConfigForm = new DBConfigDialog();
				}
				dbConfigForm.setVisible(true);
				dbConfigForm.init();
			}
		});

		databaseSubMenuItem.setIcon(new ImageIcon("./images/db.png"));
		pipelineSubmenuItem = new JMenuItem("Pipeline Config");
		mnConfiguration.add(pipelineSubmenuItem);
		pipelineSubmenuItem.setEnabled(false);
		pipelineSubmenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (pipelineConfigForm == null) {
					pipelineConfigForm = new PipelineConfigDialog();
				}
				pipelineConfigForm.init();
				pipelineConfigForm.setVisible(true);
			}
		});
		pipelineSubmenuItem.setIcon(new ImageIcon("./images/pipeline.png"));
		processSubmenuItem = new JMenuItem("Process Config");
		mnConfiguration.add(processSubmenuItem);
		processSubmenuItem.setEnabled(false);
		processSubmenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (processConfigForm == null) {
					processConfigForm = new ProcessConfigDialog();
				}
				processConfigForm.init();
				processConfigForm.setVisible(true);
			}
		});
		processSubmenuItem.setIcon(new ImageIcon("./images/process.png"));

		ratingMenu = new JMenu("RCRating");
		ratingMenu.setMnemonic(KeyEvent.VK_T);
		ratingMenu.setEnabled(false);
		menuBar.add(ratingMenu);

		mntmQunLTham = new JMenuItem("RC Rating");
		mntmQunLTham.setEnabled(true);
		mntmQunLTham.setVisible(true);
		mntmQunLTham.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				updateLogTimesRC();
				if (rcRating == null) {
					rcRating = new RC_Rating();
				}
				rcRating.setVisible(true);
			}
		});
		mntmQunLTham.setIcon(new ImageIcon("./images/rc_rating.png"));
		ratingMenu.add(mntmQunLTham);

		queryMenu = new JMenu("Tool");
		queryMenu.setEnabled(false);
		menuBar.add(queryMenu);

		logManagementMenuItem = new JMenuItem("Logs Management");
		logManagementMenuItem.setIcon(new ImageIcon("./images/log-32.png"));
		logManagementMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (logManagementDialog == null) {
					logManagementDialog = new LogManagementDialog();
				}
				logManagementDialog.setVisible(true);
				logManagementDialog.setLocationRelativeTo(null);
			}
		});
		logManagementMenuItem.setEnabled(false);
		queryMenu.add(logManagementMenuItem);

		//		subscribersMenuItem = new JMenuItem("Subscribers Search");
		//		subscribersMenuItem.addActionListener(new ActionListener() {
		//			public void actionPerformed(ActionEvent arg0) {
		//				if(subscriberSearchDialog == null){
		//					subscriberSearchDialog = new SubscribersSearchDialog();
		//				}
		//				subscriberSearchDialog.setVisible(true);
		//				subscriberSearchDialog.setLocationRelativeTo(null);
		//			}
		//		});

		userManagementMenuItem = new JMenuItem("User Management");
		userManagementMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (userManagementDialog == null) {
					userManagementDialog = new UserManagementDialog();
				}
				userManagementDialog.setVisible(true);
				userManagementDialog.setLocationRelativeTo(null);
				UserManagementDialog.userAdmin = username;
			}
		});
		userManagementMenuItem.setIcon(new ImageIcon("./images/user_management.png"));
		userManagementMenuItem.setEnabled(false);
		queryMenu.add(userManagementMenuItem);

		pipelineMonitoringMenuItem = new JMenuItem("Pipeline Monitoring");
		pipelineMonitoringMenuItem.setVisible(false);
		pipelineMonitoringMenuItem.setEnabled(false);
		pipelineMonitoringMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (pipelineMonitoring == null) {
					pipelineMonitoring = new PipelineMonitoring();
				}
				pipelineMonitoring.setVisible(true);
				pipelineMonitoring.setLocationRelativeTo(null);
			}
		});
		pipelineMonitoringMenuItem.setIcon(new ImageIcon("./images/monitor.png"));
		queryMenu.add(pipelineMonitoringMenuItem);

		pipelineStatisticMenuItem = new JMenuItem("Pipeline Statistic");
		pipelineStatisticMenuItem.setVisible(false);
		pipelineStatisticMenuItem.setEnabled(false);
		pipelineStatisticMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (pipelineStatistic == null) {
					try {
						pipelineStatistic = new PipelineStatistic();
					} catch (IOException e1) {
						e1.printStackTrace();
					}
				}
				pipelineStatistic.setVisible(true);
				pipelineStatistic.setLocationRelativeTo(null);
			}
		});
		pipelineStatisticMenuItem.setIcon(new ImageIcon("./images/statistic.png"));
		queryMenu.add(pipelineStatisticMenuItem);

		//		subscribersMenuItem.setIcon(new ImageIcon("./images/subscribers.png"));
		//		queryMenu.add(subscribersMenuItem);

		changePasswordMenuItem = new JMenuItem("Change Password");
		changePasswordMenuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (changePasswordDialog == null) {
					changePasswordDialog = new ChangePasswordDialog();
				}
				changePasswordDialog.setVisible(true);
				changePasswordDialog.setLocationRelativeTo(null);
			}
		});

		changePasswordMenuItem.setIcon(new ImageIcon("./images/change_pass.png"));
		queryMenu.add(changePasswordMenuItem);

		JMenu helpMenu = new JMenu("Help");
		helpMenu.setMnemonic(KeyEvent.VK_H);
		menuBar.add(helpMenu);

		JMenu mnNgnNg = new JMenu("Languages");
		helpMenu.add(mnNgnNg);

		chckbxmntmTingVit = new JCheckBoxMenuItem("Tiếng Việt");
		chckbxmntmTingVit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				System.out.println(MessageConstants.MAIN_FORM.LANGUAGE_SUPPORT_ENGLISH_ONLY);
				JOptionPane.showMessageDialog(new JFrame(), MessageConstants.MAIN_FORM.LANGUAGE_SUPPORT_ENGLISH_ONLY, "Warning", JOptionPane.WARNING_MESSAGE);
				chckbxmntmTingVit.setSelected(false);
				chckbxmntmEnglish.setSelected(true);
				return;
			}
		});
		chckbxmntmTingVit.setEnabled(true);
		mnNgnNg.add(chckbxmntmTingVit);

		chckbxmntmEnglish = new JCheckBoxMenuItem("English");
		chckbxmntmEnglish.setSelected(true);
		mnNgnNg.add(chckbxmntmEnglish);

		ButtonGroup groupLanguage = new ButtonGroup();
		groupLanguage.add(chckbxmntmTingVit);
		groupLanguage.add(chckbxmntmEnglish);

		JMenuItem mntmAbout = new JMenuItem("About Us");
		mntmAbout.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					About dialog = new About();
					dialog.setVisible(true);
				} catch (IOException e1) {
					logger.error("IOException", e1);
				}
			}
		});
		frmOpenrateUi.getContentPane().setLayout(new BorderLayout(0, 0));
		helpMenu.add(mntmAbout);

		//frame.getContentPane().add(toolBar, BorderLayout.NORTH);
		frmOpenrateUi.setJMenuBar(menuBar);

		/*
		 * ########## ADDING TOOL BAR FOR FRAMEWORK #############
		 */
		toolBar = new JToolBar();
		toolBar.setFloatable(false);
		toolBar.setVisible(true);
		toolBar.setEnabled(false);
		frmOpenrateUi.getContentPane().add(toolBar, BorderLayout.NORTH);
		JPanel mainPanel = new JPanel();
		frmOpenrateUi.getContentPane().add(mainPanel, BorderLayout.CENTER);
		mainPanel.setLayout(null);

		JPanel panel = new JPanel();
		panel.setBorder(new TitledBorder(null, "[ USAGE RATING STATUS ]", TitledBorder.CENTER, TitledBorder.TOP, new Font("Tahoma", Font.BOLD, 11), new Color(0, 128, 128)));
		panel.setBounds(659, 13, 693, 621);
		mainPanel.add(panel);
		panel.setLayout(null);

		JScrollPane scrollPane_1 = new JScrollPane();
		scrollPane_1.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		scrollPane_1.setBounds(21, 64, 655, 496);
		panel.add(scrollPane_1);

		eciLogArea = new JTextArea();
		eciLogArea.setForeground(new Color(255, 165, 0));
		eciLogArea.setFont(new Font("Consolas", Font.PLAIN, 13));
		eciLogArea.setBackground(Color.BLACK);
		scrollPane_1.setViewportView(eciLogArea);

		lblEciStatus = new JLabel("Status: Idle");
		lblEciStatus.setForeground(new Color(0, 0, 205));
		lblEciStatus.setBounds(21, 580, 334, 16);
		panel.add(lblEciStatus);

		btnStart = new JButton("START");
		btnStart.setEnabled(false);
		btnStart.setToolTipText("START");
		btnStart.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnStart.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				startECI();
			}
		});
		btnStart.setBounds(520, 575, 73, 25);
		panel.add(btnStart);

		btnStop = new JButton("STOP");
		btnStop.setToolTipText("STOP");
		btnStop.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnStop.setEnabled(false);
		btnStop.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				stopECI();
			}
		});
		btnStop.setBounds(603, 575, 73, 25);
		panel.add(btnStop);

		JLabel lblRerateLog = new JLabel("Rerate Log:");
		lblRerateLog.setForeground(new Color(0, 0, 205));
		lblRerateLog.setBounds(21, 37, 249, 16);
		panel.add(lblRerateLog);

		setColor();

		rcPanel = new JPanel();
		rcPanel.setForeground(new Color(0, 0, 0));
		rcPanel.setBounds(12, 13, 637, 324);
		rcPanel.setLayout(null);
		rcPanel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "[ RC RATING STATUS ]", TitledBorder.CENTER, TitledBorder.TOP, new Font("Tahoma", Font.BOLD, 11), new Color(0, 128, 128)));
		mainPanel.add(rcPanel);

		rcTextArea = new JTextArea();
		rcTextArea.setBackground(new Color(0, 0, 0));
		rcTextArea.setWrapStyleWord(true);
		rcTextArea.setText("");
		rcTextArea.setLineWrap(true);
		rcTextArea.setForeground(new Color(255, 165, 0));
		rcTextArea.setFont(new Font("Tahoma", Font.PLAIN, 11));
		rcTextArea.setEditable(false);

		scrollStatus = new JScrollPane(rcTextArea);
		scrollStatus.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		scrollStatus.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		scrollStatus.setBounds(25, 63, 386, 174);
		rcPanel.add(scrollStatus);

		rcProgressBar = new JProgressBar();
		rcProgressBar.setBounds(25, 248, 590, 25);
		rcPanel.add(rcProgressBar);

		lblRcStatus = new JLabel("Rating status:");
		lblRcStatus.setForeground(new Color(0, 0, 205));
		lblRcStatus.setBounds(25, 36, 156, 16);
		rcPanel.add(lblRcStatus);

		textLogTime = new JTextArea();
		textLogTime.setBackground(new Color(0, 0, 0));
		textLogTime.setWrapStyleWord(true);
		textLogTime.setText("");
		textLogTime.setLineWrap(true);
		textLogTime.setForeground(new Color(255, 165, 0));
		textLogTime.setFont(new Font("Tahoma", Font.PLAIN, 11));
		textLogTime.setEditable(false);
		scrollTime = new JScrollPane(textLogTime);
		scrollTime.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		scrollTime.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		scrollTime.setBounds(421, 63, 194, 174);
		rcPanel.add(scrollTime);

		lblTimestoday = new JLabel("Rate today:");
		lblTimestoday.setForeground(new Color(0, 0, 205));
		lblTimestoday.setBounds(421, 36, 145, 16);
		rcPanel.add(lblTimestoday);

		btnRCDetail = new JButton("Detail GUI...");
		btnRCDetail.setToolTipText("Detail GUI...");
		btnRCDetail.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnRCDetail.setEnabled(false);
		btnRCDetail.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (rcRating != null) {
					rcRating.setVisible(true);
				}
			}
		});
		btnRCDetail.setBounds(25, 284, 140, 25);
		rcPanel.add(btnRCDetail);

		btnShowLogRC = new JButton("Lastest loader log...");
		btnShowLogRC.setToolTipText("Lastest loader log...");
		btnShowLogRC.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnShowLogRC.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String logFile = MainProcessor.getRCLogFileName();
					ShowLoaderLog dialog = new ShowLoaderLog("Lastest loader's log file: '" + logFile + "'", logFile);
					dialog.setVisible(true);
				} catch (IOException e1) {
					logger.error("IOException", e1);
				}
			}
		});
		btnShowLogRC.setEnabled(false);
		btnShowLogRC.setBounds(175, 284, 140, 25);
		rcPanel.add(btnShowLogRC);

		btnClearLog = new JButton("Clear rate time list");
		btnClearLog.setToolTipText("Clear rate time list");
		btnClearLog.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnClearLog.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				clearRateTimeLog();
			}
		});
		btnClearLog.setEnabled(false);
		btnClearLog.setBounds(475, 284, 140, 25);
		rcPanel.add(btnClearLog);

		btnShowBadRC = new JButton("Lastest loader bad...");
		btnShowBadRC.setToolTipText("Lastest loader bad...");
		btnShowBadRC.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnShowBadRC.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					String badFile = MainProcessor.getRCBadFileName();
					ShowLoaderLog dialog = new ShowLoaderLog("Lastest loader's bad file: '" + badFile + "'", badFile);
					dialog.setVisible(true);
				} catch (IOException e1) {
					logger.error("IOException", e1);
				}
			}
		});
		btnShowBadRC.setEnabled(false);
		btnShowBadRC.setBounds(325, 284, 140, 25);
		rcPanel.add(btnShowBadRC);

		panelSummary = new JPanel();
		panelSummary.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "[ SUMMARY INFORMATION ]", TitledBorder.CENTER, TitledBorder.TOP, new Font("Tahoma", Font.BOLD, 11), new Color(0, 128, 128)));
		panelSummary.setBounds(12, 348, 637, 286);
		mainPanel.add(panelSummary);

		/*
		 * add rc_rating toolBar
		 */

		btnRcRatingConfig = new JButton("");
		btnRcRatingConfig.setToolTipText("RC Rating Config");
		btnRcRatingConfig.setIcon(new ImageIcon("./images/rc_rating_config.png"));
		btnRcRatingConfig.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (rcConfig == null) {
					try {
						rcConfig = new RC_ConfigDialog();
					} catch (IOException e1) {
						e1.printStackTrace();
					}
				}
				rcConfig.setVisible(true);
			}
		});
		btnRcRatingConfig.setEnabled(false);
		toolBar.add(btnRcRatingConfig);
		/*
		 * add rc_tariff config toolBar
		 */

		btnRcTariffConfig = new JButton("");
		btnRcTariffConfig.setToolTipText("RC Tariff Config");
		btnRcTariffConfig.setIcon(new ImageIcon("./images/tariff.png"));
		btnRcTariffConfig.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (rcTariffDialog == null) {
					rcTariffDialog = new RCTariffDialog();
				}
				rcTariffDialog.setVisible(true);
			}
		});
		btnRcTariffConfig.setEnabled(false);
		toolBar.add(btnRcTariffConfig);

		/*
		 * add rating process toolBar
		 */
		btnInputAdapter = new JButton("");
		btnInputAdapter.setToolTipText("Usage Rating Config");
		btnInputAdapter.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (ratingUsageConfigDialog == null) {
					ratingUsageConfigDialog = new RatingUsageConfigDialog();
				}
				ratingUsageConfigDialog.init();
				ratingUsageConfigDialog.setVisible(true);
			}
		});
		btnInputAdapter.setIcon(new ImageIcon("./images/usage_rating.png"));
		btnInputAdapter.setEnabled(false);
		toolBar.add(btnInputAdapter);

		/*
		 * add dbconfig toolBar
		 */
		btnDbConfig = new JButton("");
		btnDbConfig.setToolTipText("Database Config");
		btnDbConfig.setIcon(new ImageIcon("./images/db.png"));
		btnDbConfig.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (dbConfigForm == null) {
					dbConfigForm = new DBConfigDialog();
				}
				dbConfigForm.setVisible(true);
				dbConfigForm.init();
			}
		});
		btnDbConfig.setEnabled(false);
		toolBar.add(btnDbConfig);

		/*
		 * add pipeline config toolBar
		 */
		btnPipeline = new JButton("");
		btnPipeline.setToolTipText("Pipeline Config");
		btnPipeline.setIcon(new ImageIcon("./images/pipeline.png"));
		btnPipeline.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (pipelineConfigForm == null) {
					pipelineConfigForm = new PipelineConfigDialog();
				}
				pipelineConfigForm.init();
				pipelineConfigForm.setVisible(true);
			}
		});
		btnPipeline.setEnabled(false);
		toolBar.add(btnPipeline);

		/*
		 * add input process config toolBar
		 */
		btnProcessConfig = new JButton("");
		btnProcessConfig.setToolTipText("Process Config");
		btnProcessConfig.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (processConfigForm == null) {
					processConfigForm = new ProcessConfigDialog();
				}
				processConfigForm.init();
				processConfigForm.setVisible(true);
			}
		});
		btnProcessConfig.setIcon(new ImageIcon("./images/process.png"));
		btnProcessConfig.setEnabled(false);
		toolBar.add(btnProcessConfig);

		/*
		 * add query toolBar
		 */
		btnRcRating = new JButton("");
		btnRcRating.setToolTipText("RC Rating");
		btnRcRating.setIcon(new ImageIcon("./images/rc_rating.png"));
		btnRcRating.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				updateLogTimesRC();
				if (rcRating == null) {
					rcRating = new RC_Rating();
				}
				rcRating.setVisible(true);
			}
		});
		btnRcRating.setEnabled(false);
		toolBar.add(btnRcRating);

		/*
		 * add query toolBar
		 */
		btnLogManagement = new JButton("");
		btnLogManagement.setToolTipText("Log Management");
		btnLogManagement.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (logManagementDialog == null) {
					logManagementDialog = new LogManagementDialog();
				}
				logManagementDialog.setVisible(true);
				logManagementDialog.setLocationRelativeTo(null);
			}
		});
		btnLogManagement.setIcon(new ImageIcon("./images/log-32.png"));
		btnLogManagement.setEnabled(false);
		toolBar.add(btnLogManagement);

		btnUserManagement = new JButton("");
		btnUserManagement.setToolTipText("User Management");
		btnUserManagement.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (userManagementDialog == null) {
					userManagementDialog = new UserManagementDialog();
				}
				userManagementDialog.setVisible(true);
				userManagementDialog.setLocationRelativeTo(null);
				UserManagementDialog.userAdmin = username;
			}
		});
		btnUserManagement.setIcon(new ImageIcon("./images/user_management.png"));
		btnUserManagement.setEnabled(false);
		toolBar.add(btnUserManagement);

		//		btnQuerySubscriber = new JButton("  ");
		//		btnQuerySubscriber.setToolTipText("Subscriber Search");
		//		btnQuerySubscriber.addActionListener(new ActionListener() {
		//			public void actionPerformed(ActionEvent arg0) {
		//				if(subscriberSearchDialog == null){
		//					subscriberSearchDialog = new SubscribersSearchDialog();
		//				}
		//				subscriberSearchDialog.setVisible(true);
		//				subscriberSearchDialog.setLocationRelativeTo(null);
		//			}
		//		});

		btnPipelineMonitor = new JButton("");
		btnPipelineMonitor.setVisible(false);
		btnPipelineMonitor.setToolTipText("Pipeline Monitoring");
		btnPipelineMonitor.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (pipelineMonitoring == null) {
					pipelineMonitoring = new PipelineMonitoring();
				}
				pipelineMonitoring.setVisible(true);
				pipelineMonitoring.setLocationRelativeTo(null);
			}
		});

		btnChangePassword = new JButton("");
		btnChangePassword.setToolTipText("Change Password");
		btnChangePassword.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (changePasswordDialog == null) {
					changePasswordDialog = new ChangePasswordDialog();
				}
				changePasswordDialog.setVisible(true);
				changePasswordDialog.setLocationRelativeTo(null);
			}
		});
		btnChangePassword.setIcon(new ImageIcon("./images/change_pass.png"));
		btnChangePassword.setEnabled(false);
		toolBar.add(btnChangePassword);
		btnPipelineMonitor.setIcon(new ImageIcon("./images/monitor.png"));
		btnPipelineMonitor.setEnabled(false);
		toolBar.add(btnPipelineMonitor);

		btnPipelineStatistic = new JButton("");
		btnPipelineStatistic.setVisible(false);
		btnPipelineStatistic.setToolTipText("Pipeline Monitoring");
		btnPipelineStatistic.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (pipelineStatistic == null) {
					try {
						pipelineStatistic = new PipelineStatistic();
					} catch (IOException e) {
						logger.error("IOException", e);
					}
				}
				pipelineStatistic.setVisible(true);
				pipelineStatistic.setLocationRelativeTo(null);
			}
		});
		btnPipelineStatistic.setIcon(new ImageIcon("./images/statistic.png"));
		btnPipelineStatistic.setEnabled(false);
		toolBar.add(btnPipelineStatistic);

		/*
		 * add rc toolBar
		 */

		tableModel = new MyTableModel();
		tableModel.setColumnNames(columnNames);
		tableInfo = new MySortedJTable(tableModel);
		tableInfo.setBounds(23, 36, 591, 190);
		tableInfo.setFont(new Font("Tahoma", Font.BOLD, 11));
		tableInfo.getTable().getTableHeader().setForeground(Color.BLUE);
		tableInfo.getTable().getTableHeader().setBackground(Color.ORANGE);

		DefaultTableCellRenderer sumRenderer = new DefaultTableCellRenderer();
		sumRenderer.setHorizontalAlignment(JLabel.RIGHT);
		tableInfo.getTable().getColumnModel().getColumn(0).setPreferredWidth(270);
		tableInfo.getTable().getColumnModel().getColumn(0).setCellRenderer(sumRenderer);
		tableInfo.getTable().getColumnModel().getColumn(1).setCellRenderer(sumRenderer);
		tableInfo.setEnabled(false);

		panelSummary.setLayout(null);
		panelSummary.add(tableInfo);

		btnRefresh = new JButton("Refresh Information");
		btnRefresh.setToolTipText("Refresh Information");
		btnRefresh.setFont(new Font("Tahoma", Font.PLAIN, 11));
		btnRefresh.setEnabled(false);
		btnRefresh.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				try {
					addSummaryData(false);
				} catch (SQLException e) {
					logger.error("SQLException", e);
				} catch (IOException e) {
					logger.error("IOException", e);
				}
			}
		});
		btnRefresh.setBounds(474, 237, 140, 25);
		panelSummary.add(btnRefresh);

		csvFileTableModel = new MyTableModel();
		csvFileTableModel.setColumnNames(csvFileColumnNames);

		DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
		centerRenderer.setHorizontalAlignment(JLabel.CENTER);

		DefaultTableCellRenderer leftRenderer = new DefaultTableCellRenderer();
		leftRenderer.setHorizontalAlignment(JLabel.LEFT);

		/*
		 * load processing log screen
		 */
		loadProcessingRatingLog();
		addSummaryData(true);

	}

	@SuppressWarnings("rawtypes")
	protected void stopECI() {
		btnStart.setEnabled(true);
		btnStop.setEnabled(false);
		setColor();

		logger.warn("Stop rating core framework");
		eciIsRunning = false;
		/*
		 * run bat file
		 */
		worker = new SwingWorker() {
			@Override
			protected Object doInBackground() throws Exception {
				int result = MainProcessor.stopECI();
				if (result == 0) {
					lblEciStatus.setForeground(Color.BLUE);
					eciIsRunning = false;
					stopedAt = DateUtils.getCurrentDateTime(DateUtils.yyyy_MM_dd_HHmmss_sss);
				}
				if (result == -31) {
					lblEciStatus.setForeground(Color.RED);
					lblEciStatus.setText(MessageConstants.ECI_STOP.PROGRAM_IS_NOT_RUNNING);
				}
				if (result == -32) {
					lblEciStatus.setForeground(Color.RED);
					lblEciStatus.setText(MessageConstants.ECI_STOP.IO_EXCEPTION);
				}

				return null;
			}
		};
		worker.execute();
	}

	@SuppressWarnings("rawtypes")
	protected void startECI() {
		worker = new SwingWorker() {
			@Override
			protected Object doInBackground() throws Exception {
				//frmOpenrateUi.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
				int result = MainProcessor.startECI();
				//frmOpenrateUi.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
				if (result == 0) {
					lblEciStatus.setForeground(Color.BLUE);
					logger.warn(MessageConstants.ECI_START.COMPLETED);
					btnStop.setEnabled(true);
					eciIsRunning = true;
					setStartedFrom(DateUtils.getCurrentDateTime(DateUtils.yyyy_MM_dd_HHmmss_sss));
				}
				if (result == -21) {
					lblEciStatus.setForeground(Color.RED);
					logger.warn(MessageConstants.ECI_START.PORT_IN_USED);
				}
				if (result == -22) {
					lblEciStatus.setForeground(Color.RED);
					logger.warn(MessageConstants.ECI_START.IO_EXCEPTION);
				}
				return null;
			}
		};
		worker.execute();
	}

	@SuppressWarnings("rawtypes")
	private static void loadProcessingRatingLog() {
		worker = new SwingWorker() {
			@Override
			protected Object doInBackground() throws Exception {
				while (true) {
					System.out.append("");
					if (loginForm.getIsLogin()) {
						sizeTemp = logArray.size();
						Thread.sleep(3000);
						logArray = testWs.getLog();
						sizeOfLog = logArray.size();

						if (sizeOfLog > sizeTemp) {
							for (int i = sizeTemp; i < sizeOfLog; i++) {
								eciLogArea.append(logArray.get(i));
								eciLogArea.append("\n");
							}
							eciLogArea.setCaretPosition(eciLogArea.getDocument().getLength());
						}

						if (eciIsRunning) {
							btnStart.setEnabled(false);
							btnStop.setEnabled(true);

							if (StringUtils.isNotEmpty(startedFrom)) {
								lblEciStatus.setText("Status : Running " + "\t" + "from: " + startedFrom);
							} else {

								lblEciStatus.setText("Status : Running ");
							}
						} else {
							btnStart.setEnabled(true);
							btnStop.setEnabled(false);

							if (StringUtils.isNotEmpty(stopedAt)) {
								lblEciStatus.setText("Status : Idle " + "\t" + "at: " + stopedAt);
							} else {
								lblEciStatus.setText("Status : Idle ");
							}
						}
					} else {
						btnStart.setEnabled(false);
						btnStop.setEnabled(false);

						lblEciStatus.setText("Status : Idle ");
					}
					setColor();
				}
			}
		};
		worker.execute();
	}

	protected void logout() throws SQLException, IOException {
		if (isRunning()) {
			JOptionPane.showMessageDialog(frmOpenrateUi, MessageConstants.MAIN_FORM.WARNING_PROGRAM_IS_RUNNING, "Warning", JOptionPane.WARNING_MESSAGE);
			return;
		}
		int dialogResult = JOptionPane.showConfirmDialog(frmOpenrateUi, MessageConstants.MAIN_FORM.ASK_FOR_LOGOUT, "Confirmation", JOptionPane.YES_NO_OPTION);
		if (dialogResult == JOptionPane.YES_OPTION) {
			loginForm.getPasswordTxtField().setText("");
			loginForm.setIsLogin(false);
			logArray = new ArrayList<String>();
			logger.warn("Logout successfully!");
			frmOpenrateUi.dispose();
			initialize();
			frmOpenrateUi.setVisible(true);

		} else {
			return;
		}
	}

	public static void checkLoginStatus() throws SQLException, IOException {
		if (loginForm.getIsLogin()) {
			loginForm.dispose();
			/*
			 * enable menu
			 */
			if (loginForm.getRole() == IConstant.USER_ROLE_CODE.ADMIN) {
				logger.warn("ROLE: " + IConstant.USER_ROLE.ADMIN);
				btnRcRating.setEnabled(true);
				ratingMenu.setEnabled(true);
				rcConfigMenuItem.setEnabled(true);
				mntmQunLTham.setEnabled(true);
				btnRcRatingConfig.setEnabled(true);
				btnRcTariffConfig.setEnabled(true);
				btnRefresh.setEnabled(true);
				btnShowLogRC.setEnabled(true);
				btnClearLog.setEnabled(true);
				updateLogTimesRC();
				databaseSubMenuItem.setEnabled(true);
				pipelineSubmenuItem.setEnabled(true);
				processSubmenuItem.setEnabled(true);
				usageRatingMenuItem.setEnabled(true);
				btnDbConfig.setEnabled(true);
				btnInputAdapter.setEnabled(true);
				btnProcessConfig.setEnabled(true);
				rcTariffConfig.setEnabled(true);
				btnPipeline.setEnabled(true);
				tableInfo.setEnabled(true);
				logManagementMenuItem.setEnabled(true);
				btnLogManagement.setEnabled(true);
				userManagementMenuItem.setEnabled(true);
				pipelineMonitoringMenuItem.setEnabled(true);
				pipelineStatisticMenuItem.setEnabled(true);
				//pipelineStatistic
				mnConfiguration.setEnabled(true);
				btnUserManagement.setEnabled(true);
				btnChangePassword.setEnabled(true);
				btnPipelineMonitor.setEnabled(true);
				btnPipelineStatistic.setEnabled(true);
				/*
				 * check ECI is running
				 */
				checkEciRunning();
				loadProcessingRatingLog();

			} else if (loginForm.getRole() == IConstant.USER_ROLE_CODE.RATING_RC) {
				logger.warn("ROLE: " + IConstant.USER_ROLE.RATING_RC);
				btnRcRating.setEnabled(true);
				ratingMenu.setEnabled(true);
				rcConfigMenuItem.setEnabled(true);
				mntmQunLTham.setEnabled(true);
				btnRcRatingConfig.setEnabled(true);
				btnRcTariffConfig.setEnabled(true);
				btnRefresh.setEnabled(true);
				btnShowLogRC.setEnabled(true);
				btnClearLog.setEnabled(true);
				mnConfiguration.setEnabled(true);
				btnChangePassword.setEnabled(true);
				rcTariffConfig.setEnabled(true);
				updateLogTimesRC();
			} else if (loginForm.getRole() == IConstant.USER_ROLE_CODE.MONITOR) {
				logger.warn("ROLE: " + IConstant.USER_ROLE.MONITOR);
				databaseSubMenuItem.setEnabled(true);
				pipelineSubmenuItem.setEnabled(true);
				processSubmenuItem.setEnabled(true);
				usageRatingMenuItem.setEnabled(true);
				btnDbConfig.setEnabled(true);
				btnInputAdapter.setEnabled(true);
				btnProcessConfig.setEnabled(true);
				btnPipeline.setEnabled(true);
				tableInfo.setEnabled(true);
				mnConfiguration.setEnabled(true);
				btnChangePassword.setEnabled(true);
				/*
				 * check ECI is running
				 */
				int status = testWs.checkStatus();
				if (status == 1) {
					eciIsRunning = true;
					btnStart.setEnabled(false);
					btnStop.setEnabled(true);
					lblEciStatus.setText("Status : Running ");
				} else {
					eciIsRunning = false;
					btnStart.setEnabled(true);
					btnStop.setEnabled(false);
					lblEciStatus.setText("Status : Idle ");
				}
				loadProcessingRatingLog();
			}
			else {
				logger.warn("ROLE: " + IConstant.USER_ROLE.VIEWER);
				/*
				 * disable menu
				 */
				btnChangePassword.setEnabled(true);
				loginMenuItem.setEnabled(false);
				rcConfigMenuItem.setEnabled(false);
				databaseSubMenuItem.setEnabled(false);
				pipelineSubmenuItem.setEnabled(false);
				processSubmenuItem.setEnabled(false);
				mntmQunLTham.setEnabled(false);
				usageRatingMenuItem.setEnabled(false);
				btnDbConfig.setEnabled(false);
				btnInputAdapter.setEnabled(false);
				btnProcessConfig.setEnabled(false);
				btnPipeline.setEnabled(false);
				btnRcRatingConfig.setEnabled(false);
				btnRcRating.setEnabled(false);
				//btnQuerySubscriber.setEnabled(false);
				btnLogManagement.setEnabled(false);
				ratingMenu.setEnabled(false);
				toolBar.setEnabled(false);
				queryMenu.setEnabled(false);
				toolBar.setEnabled(false);
				btnRefresh.setEnabled(false);
				btnShowLogRC.setEnabled(false);
				btnClearLog.setEnabled(false);
				tableInfo.setEnabled(false);
				btnShowBadRC.setEnabled(false);
				btnChangePassword.setEnabled(true);
				addSummaryData(true);

				/*
				 * enable login menu
				 */
				loginMenuItem.setText("Log in");
				loginMenuItem.setIcon(new ImageIcon(".\\images\\login.png"));
				loginMenuItem.setEnabled(true);

				/*
				 * clear log screen
				 */
			}
			loginMenuItem.setEnabled(true);
			//btnQuerySubscriber.setEnabled(true);
			queryMenu.setEnabled(true);
			setEnableShowBadRC();

			/*
			 * display summary information
			 */
			addSummaryData(true);

			/*
			 * enable logout menu
			 */
			loginMenuItem.setText("Log out");
			loginMenuItem.setIcon(new ImageIcon("./images/1_logout.png"));
			toolBar.setEnabled(true);
			setColor();
		}
	}

	@SuppressWarnings("rawtypes")
	private static void checkEciRunning() {
		worker = new SwingWorker() {
			@Override
			protected Object doInBackground() throws Exception {
				while (true) {
					int status = testWs.checkStatus();
					if (status == 1) {
						eciIsRunning = true;
						btnStart.setEnabled(false);
						btnStop.setEnabled(true);
						//lblEciStatus.setText("Status : Running ");
					} else {
						eciIsRunning = false;
						btnStart.setEnabled(true);
						btnStop.setEnabled(false);
						//lblEciStatus.setText("Status : Idle ");
					}
					Thread.sleep(1000);
				}
			}
		};
		worker.execute();
	}

	private static void setEnableShowBadRC() throws IOException {
		btnShowBadRC.setEnabled(MainProcessor.hasRC_BadFile());
	}

	private static void setColor() {
		if (btnStart.isEnabled())
			btnStart.setForeground(Color.BLUE);
		else
			btnStart.setForeground(Color.LIGHT_GRAY);

		if (btnStop.isEnabled())
			btnStop.setForeground(Color.RED);
		else
			btnStop.setForeground(Color.LIGHT_GRAY);
	}

	public static void updateLogTimesRC() {
		MainProcessor.updateLogTimesRC(textLogTime, lblTimestoday);
	}

	public static String getStartedFrom() {
		return startedFrom;
	}

	public static void setStartedFrom(String startedFrom) {
		MainApplicationUI.startedFrom = startedFrom;
	}

	private void clearRateTimeLog() {
		frmOpenrateUi.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		;
		MainProcessor.clearRateTimeLog(textLogTime);
		frmOpenrateUi.setCursor(Cursor.getDefaultCursor());
	}

	public static void setShowDetailRC(boolean b) {
		btnRCDetail.setEnabled(b);
		if (b)
			rcTextArea.setText("");
	}

	public static void setProgressValue(int value) {
		rcProgressBar.setValue(value);
	}

	public static void setIndeterminate(boolean b) {
		rcProgressBar.setIndeterminate(b);
		rcProgressBar.setStringPainted(!b);
	}

	public static void setProgressMax(int max) {
		rcProgressBar.setMaximum(max);
	}

	public static void setStatus(String s) {
		rcTextArea.append(s + "\n");
		rcTextArea.setCaretPosition(rcTextArea.getDocument().getLength());
	}

	public static void clearStatus() {
		rcTextArea.setText("");
	}

	public static void setCloseRC() {
		if (rcRating != null) {
			rcRating.dispose();
			rcRating = null;
		}
	}

	private static void addSummaryData(boolean nullValue) throws SQLException, IOException {
		frmOpenrateUi.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		boolean b = btnRefresh.isEnabled();
		btnRefresh.setEnabled(false);
		MainProcessor.addSummaryData(nullValue, tableModel, tableInfo);
		btnRefresh.setEnabled(b);
		frmOpenrateUi.setCursor(Cursor.getDefaultCursor());
	}

	@SuppressWarnings("static-access")
	private static Boolean isRunning() {
		if (rcRating != null)
			if (rcRating.isRunning()) {
				return true;
			} else
				return false;
		else
			return false;
	}
}
