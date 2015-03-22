package eonerateui.gui.menu.tool;

import java.awt.Color;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;
import javax.swing.table.DefaultTableCellRenderer;

import com.toedter.calendar.JDateChooser;

import eonerateui.controller.main.MainProcessor;
import eonerateui.db.ProductDAO;
import eonerateui.db.SubscriberDAO;
import eonerateui.entity.search.output.DiscountSearchOutput;
import eonerateui.entity.search.output.PricesSearchOutput;
import eonerateui.entity.search.output.ProductSearchOutput;
import eonerateui.entity.search.output.SubscriberSearchOutput;
import eonerateui.gui.util.MySortedJTable;
import eonerateui.gui.util.MyTableModel;
import eonerateui.util.DateUtils;

public class SubscribersSearchDialog extends JDialog {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private JTextField subscribersTextField;
	private JDateChooser toDateChooser;
	private JDateChooser fromDateChooser;
	private JComponent inputPanel;
	private JButton btnSubmit;
	private static final String[] columnNames = {"Subcriber No", "Start Date", "End Date", "Subscriber Version Id" };
	private static final String[] productColumnNames = {"Subcriber No", "Start Date", "End Date", "Product Version Name"};
	private static final String[] pricesColumnNames = {"Price Model", "Step", "Tier From", "Tier To", "Beat", "Factor", "Charge Base"};
	private static final String[] discountColumnNames = {"Package", "Zone", "Discount Out"};
	private MySortedJTable productSortedJTable;
	private MySortedJTable subscribersSortedJtable;
	private MySortedJTable pricesSortedJtable;
	private MySortedJTable discountSortedJtable;
	private JTabbedPane tabbedPane;
	private JButton btnLast;
	private JButton btnNext;
	private static Boolean isEnablePriceSearch = false;
	private static Boolean isEnableDiscount = false;
	
	/**
	 * Create the dialog.
	 */
	public SubscribersSearchDialog() {
		setModal(true);
		setModalityType(ModalityType.APPLICATION_MODAL);
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setTitle("Subscriber Search");
		setResizable(false);
		setLocationRelativeTo(null);
//		try {
//			UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
//		} catch(Exception e){
//			e.printStackTrace();
//		}
		SubscribersSearchDialog.setDefaultLookAndFeelDecorated(true);
		
		
		setBounds(100, 100, 777, 532);
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		addInputPanel();
		initTable();
	}

	private void addInputPanel() {
		inputPanel = new JPanel();
		inputPanel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "Subscriber Detail", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		inputPanel.setBounds(10, 11, 750, 91);
		getContentPane().add(inputPanel);
		inputPanel.setLayout(null);
		
		fromDateChooser = new JDateChooser();
		fromDateChooser.setDateFormatString("MM/dd/yyyy");
		fromDateChooser.setBounds(337, 47, 187, 25);
		inputPanel.add(fromDateChooser);
		
		JLabel lblFromDate = new JLabel("From Date:");
		lblFromDate.setBounds(337, 29, 73, 16);
		inputPanel.add(lblFromDate);
		
		JLabel lblToDate = new JLabel("To Date:");
		lblToDate.setBounds(552, 29, 54, 16);
		inputPanel.add(lblToDate);
		
		JLabel lblSubscriber = new JLabel("Subscriber No:");
		lblSubscriber.setBounds(27, 29, 99, 16);
		inputPanel.add(lblSubscriber);
		
		subscribersTextField = new JTextField();
		subscribersTextField.setBounds(27, 47, 281, 25);
		inputPanel.add(subscribersTextField);
		subscribersTextField.setColumns(10);
		
		toDateChooser = new JDateChooser();
		toDateChooser.setDateFormatString("MM/dd/yyyy");
		toDateChooser.setBounds(552, 47, 186, 25);
		inputPanel.add(toDateChooser);
		
		btnSubmit = new JButton("Submit");
		btnSubmit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				searchData();
			}
		});
		btnSubmit.setBounds(601, 461, 73, 25);
		getContentPane().add(btnSubmit);
		btnSubmit.setFont(new Font("Tahoma", Font.PLAIN, 13));
		btnSubmit.setForeground(Color.BLACK);
		
	}

	/**
	 * TODO	get all the subscriber from ALIAS & ACCOUNT_VERSION table
	 * 
	 * @param subscriptionId
	 * @param fromDate
	 * @param toDate
	 * 
	 * @returnArrayList<SubscriberSearchOutput>
	 * 
	 * @author Son.Pham.Hong
	 * @date 26 Nov 2013
	 */
	protected void searchData() {
		//get input data
		String subscriptionId = subscribersTextField.getText();
		//Date fromDate = fromDateChooser.getDate();
		//Date toDate = toDateChooser.getDate();
		String fromDate = DateUtils.getDateStringInformat(fromDateChooser.getDate(), fromDateChooser.getDateFormatString());
		String toDate = DateUtils.getDateStringInformat(toDateChooser.getDate(), toDateChooser.getDateFormatString());
		
		
		setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		ArrayList<SubscriberSearchOutput> listSubscriber = SubscriberDAO.searchSubscriber(subscriptionId, fromDate, toDate);
		setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));	
		Integer size = listSubscriber.size();
		//int size = 8000000;
		if(size > 0){
			int numberOfColumn = columnNames.length; 
			Object[][] data = new Object[size][numberOfColumn];
			for(int i = 0 ; i < size ; i ++){
				data[i][0] = listSubscriber.get(i).getSubscriptionId();
				data[i][1] = listSubscriber.get(i).getStartDate();
				data[i][2] = listSubscriber.get(i).getEndDate();
				data[i][3] = listSubscriber.get(i).getSubscriberVersionId();
			}
			MyTableModel tableModel = new MyTableModel();
			tableModel.setColumnNames(columnNames);
			tableModel.setData(data);

			subscribersSortedJtable.getTable().setModel(tableModel);
			
			subscribersSortedJtable.getTable().getColumnModel().getColumn(0).setPreferredWidth(70);
			subscribersSortedJtable.getTable().getColumnModel().getColumn(1).setPreferredWidth(100);
			subscribersSortedJtable.getTable().getColumnModel().getColumn(2).setPreferredWidth(100);
			subscribersSortedJtable.getTable().getColumnModel().getColumn(3).setPreferredWidth(50);
			
			DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
			centerRenderer.setHorizontalAlignment( JLabel.CENTER );
			subscribersSortedJtable.getTable().getColumnModel().getColumn(3).setCellRenderer(centerRenderer);
			
		}else{
			MyTableModel tableModel = new MyTableModel();
			tableModel.setColumnNames(columnNames);
			subscribersSortedJtable.getTable().setModel(tableModel);
		}
		
		repaint();
	}

	private void initTable() {
		/*
		 * STEP 1: init the subscriber sorted table
		 */
		MyTableModel tableModel = new MyTableModel();
		tableModel.setColumnNames(columnNames);
		subscribersSortedJtable = new MySortedJTable(tableModel);
		
		subscribersSortedJtable.setBounds(10, 115, 749, 164);
		getContentPane().add(subscribersSortedJtable);
		
		/*
		 * STEP 2: add subscriber selection event click
		 */
		subscribersSortedJtable.getTable().setColumnSelectionAllowed(false);
		subscribersSortedJtable.getTable().setRowSelectionAllowed(true);
		
        subscribersSortedJtable.getTable().addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent me) {
                JTable table =(JTable) me.getSource();
                Point p = me.getPoint();
                int selectedRow = table.rowAtPoint(p);
                if (me.getClickCount() == 2) {
                	String subscriptionId = (String)subscribersSortedJtable.getTable().getModel().getValueAt(selectedRow, 0);
                	searchProduct(subscriptionId);
                }
            }
        });
		
		/*
		 * STEP 3: init the tabbedPane (this including 3 tabs: Products, Prices, Discount)
		 */
		tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane.setBounds(10, 317, 750, 135);
		getContentPane().add(tabbedPane);
		
		
		
		/*
		 * STEP 3.1: adding product table
		 */
		MyTableModel productTableModels = new MyTableModel();
		productTableModels.setColumnNames(productColumnNames);
		productSortedJTable = new MySortedJTable(productTableModels);
		productSortedJTable.setBorder(null);
		productSortedJTable.setBounds(20, 388, 750, 87);
		tabbedPane.add(productSortedJTable);
		tabbedPane.setTitleAt(0, "Product");
		productSortedJTable.getTable().setColumnSelectionAllowed(false);
		productSortedJTable.getTable().setRowSelectionAllowed(true);
		
		/*
		 * STEP 3.1.1 add product clicked event
		 */
		
		if(isEnablePriceSearch){
			productSortedJTable.getTable().addMouseListener(new MouseAdapter() {
	            public void mousePressed(MouseEvent me) {
	                JTable table =(JTable) me.getSource();
	                Point p = me.getPoint();
	                int selectedRow = table.rowAtPoint(p);
	                if (me.getClickCount() == 2) {
	                	String productId = (String)productSortedJTable.getTable().getModel().getValueAt(selectedRow, 3);
	                	searchPricesModel(productId);
	                }
	            }
	        });
			/*
			 * STEP 3.2: adding prices table
			 */
			MyTableModel pricesTableModels = new MyTableModel();
			pricesTableModels.setColumnNames(pricesColumnNames);
			pricesSortedJtable = new MySortedJTable(pricesTableModels);
			pricesSortedJtable.setBorder(null);
			pricesSortedJtable.setBounds(20, 388, 750, 87);
			tabbedPane.add(pricesSortedJtable);
			tabbedPane.setTitleAt(1, "Prices Model");
			/*
			 * STEP 3.2.1 add prices clicked event
			 */
			pricesSortedJtable.getTable().setColumnSelectionAllowed(false);
			pricesSortedJtable.getTable().setRowSelectionAllowed(true);
			pricesSortedJtable.getTable().addMouseListener(new MouseAdapter() {
	            public void mousePressed(MouseEvent me) {
	                JTable table =(JTable) me.getSource();
	                Point p = me.getPoint();
	                int selectedRow = table.rowAtPoint(p);
	                if (me.getClickCount() == 2) {
	                	String pricesModel = (String)pricesSortedJtable.getTable().getModel().getValueAt(selectedRow, 0);
	                	searchDiscount(pricesModel);
	                }
	            }
	        });
			
		}
		
		if(isEnableDiscount){
			/*
			 * STEP 3.3: adding discount table
			 */
			MyTableModel discountTableModels = new MyTableModel();
			discountTableModels.setColumnNames(discountColumnNames);
			discountSortedJtable = new MySortedJTable(discountTableModels);
			discountSortedJtable.setBorder(null);
			discountSortedJtable.setBounds(20, 388, 750, 87);
			tabbedPane.add(discountSortedJtable);
			tabbedPane.setTitleAt(2, "Discount");
		}
		
		
		JButton btnNewButton = new JButton("Close");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				dispose();
			}
		});
		btnNewButton.setBounds(686, 461, 73, 25);
		getContentPane().add(btnNewButton);
		
		btnLast = new JButton(">>|");
		btnLast.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				int numberOfRow = subscribersSortedJtable.getTable().getRowCount();
				if(numberOfRow > 0){
					subscribersSortedJtable.getTable().scrollRectToVisible(new Rectangle(subscribersSortedJtable.getTable().getCellRect(numberOfRow-1 + 1, 0, true)));
					subscribersSortedJtable.getTable().setRowSelectionInterval(numberOfRow-1, numberOfRow-1);
					String subscriptionId = (String)subscribersSortedJtable.getTable().getModel().getValueAt(numberOfRow-1, 0);
                	searchProduct(subscriptionId);
				}
			}
		});
		btnLast.setBounds(703, 290, 57, 23);
		getContentPane().add(btnLast);
		
		btnNext = new JButton(">>");
		btnNext.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int selectedRow = subscribersSortedJtable.getTable().getSelectedRow();
				int numberOfRow = subscribersSortedJtable.getTable().getRowCount();
				if(selectedRow < numberOfRow - 1){
					subscribersSortedJtable.getTable().setRowSelectionInterval(selectedRow + 1, selectedRow + 1);
					subscribersSortedJtable.getTable().scrollRectToVisible(new Rectangle(subscribersSortedJtable.getTable().getCellRect(selectedRow + 1, 0, true)));
					String subscriptionId = (String)subscribersSortedJtable.getTable().getModel().getValueAt(selectedRow + 1, 0);
                	searchProduct(subscriptionId);
				}
					
			}
		});
		btnNext.setBounds(639, 290, 57, 23);
		getContentPane().add(btnNext);
		
		JButton btnBack = new JButton("<<");
		btnBack.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int selectedRow = subscribersSortedJtable.getTable().getSelectedRow();
				if(selectedRow > 0){
					subscribersSortedJtable.getTable().setRowSelectionInterval(selectedRow - 1, selectedRow - 1);
					subscribersSortedJtable.getTable().scrollRectToVisible(new Rectangle(subscribersSortedJtable.getTable().getCellRect(selectedRow -1, 0, true)));
					String subscriptionId = (String)subscribersSortedJtable.getTable().getModel().getValueAt(selectedRow -1, 0);
                	searchProduct(subscriptionId);
				}
			}
		});
		btnBack.setBounds(570, 290, 57, 23);
		getContentPane().add(btnBack);
		
		JButton btnFirst = new JButton("|<<");
		btnFirst.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int numberOfRow = subscribersSortedJtable.getTable().getRowCount();
				if(numberOfRow > 0){
					subscribersSortedJtable.getTable().setRowSelectionInterval(0, 0);
					subscribersSortedJtable.getTable().scrollRectToVisible(new Rectangle(subscribersSortedJtable.getTable().getCellRect(0, 0, true)));
					String subscriptionId = (String)subscribersSortedJtable.getTable().getModel().getValueAt(0, 0);
                	searchProduct(subscriptionId);
				}
			}
		});
		btnFirst.setBounds(504, 290, 57, 23);
		getContentPane().add(btnFirst);
		
	}

	protected void searchDiscount(String pricesModel) {
		tabbedPane.setSelectedComponent(discountSortedJtable);
		setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		ArrayList<DiscountSearchOutput> listDiscount = MainProcessor.searchDiscount(pricesModel, "");
		setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
		Integer size = listDiscount.size();
		
		if(size > 0){
			int numberOfColumn = discountColumnNames.length; 
			Object[][] data = new Object[size][numberOfColumn];
			for(int i = 0 ; i < size ; i ++){
				data[i][0] = listDiscount.get(i).getDiscountIn();
				data[i][1] = listDiscount.get(i).getZone();
				data[i][2] = listDiscount.get(i).getDiscountOut();
			}
			MyTableModel tableModel = new MyTableModel();
			tableModel.setColumnNames(discountColumnNames);
			tableModel.setData(data);
			discountSortedJtable.getTable().setModel(tableModel);
		}else{
			MyTableModel tableModel = new MyTableModel();
			tableModel.setColumnNames(columnNames);
			discountSortedJtable.getTable().setModel(tableModel);
		}
		repaint();
	}

	/**
	 * TODO to display prices model detail in prices table
	 * @param productId
	 * 
	 * @author Son.Pham.Hong
	 * @date 27 Nov 2013
	 */
	
	protected void searchPricesModel(String productId) {
		tabbedPane.setSelectedComponent(pricesSortedJtable);
		setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		ArrayList<PricesSearchOutput> listPricesModel = MainProcessor.searchPrice(productId);
		setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
		int size = listPricesModel.size();
		if(size > 0){
			int numberOfColumn = pricesColumnNames.length; 
			Object[][] data = new Object[size][numberOfColumn];
			for(int i = 0 ; i < size ; i ++){
				data[i][0] = listPricesModel.get(i).getPriceModel();
				data[i][1] = listPricesModel.get(i).getStep();
				data[i][2] = listPricesModel.get(i).getTierFrom();
				data[i][3] = listPricesModel.get(i).getTierTo();
				data[i][4] = listPricesModel.get(i).getBeat();
				data[i][5] = listPricesModel.get(i).getFactor();
				data[i][6] = listPricesModel.get(i).getChargeBase();
			}
				MyTableModel tableModel = new MyTableModel();
				tableModel.setColumnNames(pricesColumnNames);
				tableModel.setData(data);
				pricesSortedJtable.getTable().setModel(tableModel);	
				pricesSortedJtable.getTable().getColumnModel().getColumn(0).setPreferredWidth(200);
		}else{
			MyTableModel tableModel = new MyTableModel();
			tableModel.setColumnNames(pricesColumnNames);
			pricesSortedJtable.getTable().setModel(tableModel);
		}
		repaint();
	}

	/**
	 * TODO to display product detail in product table
	 * @param subscriptionId
	 * 
	 * @author Son.Pham.Hong
	 * @date 27 Nov 2013
	 */
	
	protected void searchProduct(String subscriptionId) {
		//display the product corresponding with subscriptionId
		tabbedPane.setSelectedComponent(productSortedJTable);
		setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		ArrayList<ProductSearchOutput> listProduct = ProductDAO.searchProduct(subscriptionId, null, null);
		setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));	
		Integer size = listProduct.size();
		if(size > 0){
			int numberOfColumn = productColumnNames.length; 
			Object[][] data = new Object[size][numberOfColumn];
			for(int i = 0 ; i < size ; i ++){
				data[i][0] = listProduct.get(i).getSubscriberNo();
				data[i][1] = listProduct.get(i).getStartDate();
				data[i][2] = listProduct.get(i).getEndDate();
				data[i][3] = listProduct.get(i).getProductOfferVersionName();
			}
			MyTableModel tableModel = new MyTableModel();
			tableModel.setColumnNames(productColumnNames);
			tableModel.setData(data);
			productSortedJTable.getTable().setModel(tableModel);
		}else{
			MyTableModel tableModel = new MyTableModel();
			tableModel.setColumnNames(productColumnNames);
			productSortedJTable.getTable().setModel(tableModel);
		}
		repaint();
	}
}
