package eonerateui.gui.menu.configuration;


import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.Box;
import javax.swing.ButtonGroup;
import javax.swing.ButtonModel;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTable;
import javax.swing.RowFilter;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;
import javax.swing.table.TableRowSorter;

import org.apache.commons.lang3.StringUtils;

import eonerateui.db.RCTariffDAO;
import eonerateui.db.pool.DBPool;
import eonerateui.gui.util.ComboItem;
import eonerateui.gui.util.FilterComboBox;
import eonerateui.gui.util.MySortedJTable;
import eonerateui.gui.util.MyTableModel;
import eonerateui.gui.util.RadioButtonUI;
import eonerateui.util.Item;
import eonerateui.util.MessageConstants;
import eonerateui.util.RCTariff;


public class RCTariffDialog extends JDialog {

	/**
	 * 
	 */
	public static QuickRCTariffDialog quickRCTariffDialog;
	public static UpdateRCTariffDialog upDateDialog;
	private static final long serialVersionUID = 1L;
	private static MySortedJTable tariffJTable;
	public static MyTableModel model = new MyTableModel();
	private JButton btnDelete;
	private static int size;
	private static ArrayList<RCTariff> listRCTariff = new ArrayList<RCTariff>();
	private static final String[] columnNames = {"ID","Day", "Product", "Type","Status","Value","Full cycle"};
	static int SUCCESS = 0;
	static int ERROR = -1;
	private JFrame frame;
	private static FilterComboBox cbProduct;
	private static JComboBox cbType;
	private static JComboBox cbStatus;
	private JButton btnUpdate;
	private static ArrayList<Item> listItem = new ArrayList<Item>();
	private ArrayList<Item> listTypeRC = new ArrayList<Item>();
	private ArrayList<Item> listStatusRC = new ArrayList<Item>();
	private Integer Id=null;
	private String OfferName="";
	private String StatusName="";
	private String TypeName="";
	private Integer day=null;
	private Integer value=0;
	private Boolean fullcycle=false;
	private JPanel panel;
	
	static int offSize = 20;
	final static int pageSize = 3;
	private static JPanel aditPanel;
	static RadioButtonUI ui = new RadioButtonUI();
	@SuppressWarnings({ "rawtypes", "unchecked" })
	static TableRowSorter sorter = new TableRowSorter(model);
	static Box box = Box.createHorizontalBox();
	private static JComboBox comboBox;
	private static int currentTotal;
	private static JLabel totalLabel;

	
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			
			RCTariffDialog dialog = new RCTariffDialog();
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	/**
	 * Create the dialog.
	 */
	public RCTariffDialog() {
		setResizable(false);
		setTitle("RC Tariff");
		setBounds(100, 100, 819, 591);
		setModalityType(ModalityType.APPLICATION_MODAL);
		getContentPane().setLayout(null);
		setLocationRelativeTo(null);
	
		try {
			//UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
			UIManager.setLookAndFeel("javax.swing.plaf.metal.MetalLookAndFeel");
		} catch(Exception e){
			e.printStackTrace();
		}
		RCTariffDialog.setDefaultLookAndFeelDecorated(true);
		
		btnUpdate = new JButton("Update");
		btnUpdate.setEnabled(false);
		btnUpdate.setFont(new Font("Tahoma", Font.BOLD, 12));

		btnUpdate.setBounds(98, 533, 79, 23);
		getContentPane().add(btnUpdate);
		
		panel = new JPanel();
		panel.setLayout(null);
		
		panel.setBounds(9, 0, 794, 100);
		getContentPane().add(panel);
		
		JLabel lblCode = new JLabel("Product Offer");
		lblCode.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblCode.setBounds(10, 30, 83, 14);
		panel.add(lblCode);
		
		JLabel lblNwgroup = new JLabel("RC Tariff Type");
		lblNwgroup.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblNwgroup.setBounds(413, 30, 83, 14);
		panel.add(lblNwgroup);
		
		
		
		cbType = new JComboBox();
		cbType.setBounds(529, 25, 255, 25);
		//Add set font 12 May 2014
		cbType.setFont(new Font("Tahoma", Font.PLAIN, 11));
		panel.add(cbType);
		
		cbStatus = new JComboBox();
		cbStatus.setBounds(128, 61, 255, 25);
		cbStatus.setFont(new Font("Tahoma", Font.PLAIN, 11));
		panel.add(cbStatus);
		
		JLabel lblNewLabel = new JLabel("Subscriber Status");
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 11));
		lblNewLabel.setBounds(10, 66, 105, 14);
		panel.add(lblNewLabel);
		
		final JButton btnSearch = new JButton("Search");
		btnSearch.setBounds(701, 61, 83, 25);
		panel.add(btnSearch);
		btnSearch.setFont(new Font("Tahoma", Font.BOLD, 11));
			
		btnSearch.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				searchTable();
			}
		});
		
		btnDelete = new JButton("Delete");
		btnDelete.setEnabled(false);
		btnDelete.setFont(new Font("Tahoma", Font.BOLD, 11));
		btnDelete.setBounds(187, 533, 79, 23);
		getContentPane().add(btnDelete);
		
		JButton btnClose = new JButton("Close");
		btnClose.setFont(new Font("Tahoma", Font.BOLD, 11));
		btnClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				RCTariffDialog.this.dispose();
			}
		});
		btnClose.setBounds(732, 534, 71, 23);
		getContentPane().add(btnClose);
		
		JButton btnQuickCreate = new JButton("Create");
		btnQuickCreate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				ComboItem productItem = getComboItemFromValue(cbProduct.getSelectedItem().toString());
				
				if(productItem != null )
				{
					if(cbType.getSelectedIndex() != 0)
					{
						if(cbStatus.getSelectedIndex() != 0)
						{
							ComboItem item = getComboItemFromValue(cbProduct.getSelectedItem().toString());
							ComboItem type = (ComboItem) cbType.getSelectedItem();
							ComboItem status = (ComboItem) cbStatus.getSelectedItem();
							quickRCTariffDialog = new QuickRCTariffDialog(Integer.parseInt(item.getValue()),item.getKey(),Integer.parseInt(type.getValue()),type.getKey(), Integer.parseInt(status.getValue()),status.getKey());
							quickRCTariffDialog.setVisible(true);
						}else{
							JOptionPane.showMessageDialog(frame, "You must chose subscriber status");
						}
					}else{
						
						JOptionPane.showMessageDialog(frame, "You must chose RC tariff type");
					}
				}else{
					JOptionPane.showMessageDialog(frame, MessageConstants.RC_TARIFF.PRODUCT_NOT_FOUND, "Error",  JOptionPane.ERROR_MESSAGE);
					cbProduct.requestFocus();
					return;
				}
			}
		});
		btnQuickCreate.setFont(new Font("Tahoma", Font.BOLD, 11));
		btnQuickCreate.setBounds(9, 533, 79, 23);
		getContentPane().add(btnQuickCreate);
		
		btnUpdate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				ComboItem productItem = getComboItemFromValue(cbProduct.getSelectedItem().toString());
				if(productItem == null){
					JOptionPane.showMessageDialog(frame, MessageConstants.RC_TARIFF.PRODUCT_NOT_FOUND, "Error",  JOptionPane.ERROR_MESSAGE);
					cbProduct.requestFocus();
					return;
				}
				upDateDialog = new UpdateRCTariffDialog(OfferName,TypeName,StatusName,day,Id,value,fullcycle);
				upDateDialog.setVisible(true);
			}
		});
		btnDelete.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				deleteRCTariff();
			}
		});
		
		drawTable();
		
		initValue();
		//initDay();
		initRC_Type();
		initSubsStatus();
	}

	private void initValue() {
		try {
			Connection conn = DBPool.getConnection();
			listItem = RCTariffDAO.getListProduct(conn);
			/*cbProduct.addItem(new ComboItem( "",""));
			for(Item i : listItem){
				cbProduct.addItem(new ComboItem( i.getName(),i.getId().toString()));
			}*/
			
			cbProduct = new FilterComboBox(listItem);
	        Item empty = new Item(0, "");
	        listItem.add(0, empty);
	        for(Item i : listItem){
	        	cbProduct.addItem(new ComboItem( i.getName(),i.getId().toString()));
	        }
			
	        cbProduct.setBounds(128, 25, 255, 25);
			panel.add(cbProduct);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

//	@SuppressWarnings("unchecked")
//	private void initDay() {
//		Integer[] intArray = new Integer[] { 1, 2,3,4,5,6,7,8,9,10,11,12,13,15,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 };
//		listDay = new ArrayList<Integer>(Arrays.asList(intArray));
//		for(int i=1;i<32;i++){
//			cbDay.addItem(new ComboItem(Integer.toString(i),Integer.toString(i)));
//		}
//	}

	private void initRC_Type() {
		try {
			Connection conn = DBPool.getConnection();
			listTypeRC = RCTariffDAO.getListRC_Tariff_Type(conn);
			cbType.addItem(new ComboItem( "",""));	
			for(Item i : listTypeRC){
				cbType.addItem(new ComboItem( i.getName(),i.getId().toString()));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	private void initSubsStatus() {
		try {
			Connection conn = DBPool.getConnection();
			listStatusRC = RCTariffDAO.getListSubs_Status(conn);
			cbStatus.addItem(new ComboItem( "",""));
			for(Item i : listStatusRC){
				cbStatus.addItem(new ComboItem( i.getName(),i.getId().toString()));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}



	protected void deleteRCTariff() {
		
		int typeId=0;
		int statusId=0;
		
		if(cbType.getSelectedIndex()!=0)
		{
			ComboItem item = (ComboItem) cbType.getSelectedItem();
			typeId= Integer.parseInt(item.getValue());
		}
		if(cbStatus.getSelectedIndex()!=0)
		{
			ComboItem item = (ComboItem) cbStatus.getSelectedItem();
			statusId= Integer.parseInt(item.getValue());
		}
		
		ComboItem item = getComboItemFromValue(cbProduct.getSelectedItem().toString());
		
		if(item == null){
			JOptionPane.showMessageDialog(frame, MessageConstants.RC_TARIFF.PRODUCT_NOT_FOUND, "Error",  JOptionPane.ERROR_MESSAGE);
			cbProduct.requestFocus();
			return;
		}
		
		if (JOptionPane.showConfirmDialog(frame, 
	            "Are you sure delete RC configation item no: "+item.getKey()+"  ", "Really delete?", 
	            JOptionPane.YES_NO_OPTION,
	            JOptionPane.QUESTION_MESSAGE) == JOptionPane.NO_OPTION){
	    		return;
	    }
		try{
			Connection conn = DBPool.getConnection();
			int result = RCTariffDAO.deleteAll(Integer.parseInt(item.getValue()),typeId,statusId, conn);
			if(result == SUCCESS){
				//codeTxt.setBackground(Color.WHITE);
				JOptionPane.showMessageDialog(frame, "Delete RC configuration item no: "+item.getKey()+" successfull");
				btnDelete.setEnabled(false);
				btnUpdate.setEnabled(false);
			}else{
				JOptionPane.showMessageDialog(frame, "Delete RC configuration item no: "+item.getKey()+" not successfull");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		updateTable();
	}
	
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private void drawTable() {
		MyTableModel tableModel = new MyTableModel();
		tableModel.setColumnNames(columnNames);
		tableModel.setEditable(false);
		tableModel.setData(null);
		tariffJTable = new MySortedJTable(tableModel);
		sorter = new TableRowSorter(tableModel);
		model = tableModel;
		tariffJTable.getTable().setRowSorter(sorter);
		
		tariffJTable.setFont(new Font("Tahoma", Font.PLAIN, 11));
		tariffJTable.getTable().getColumnModel().getColumn(1).setPreferredWidth(40);
		tariffJTable.getTable().getColumnModel().getColumn(2).setPreferredWidth(320);
		tariffJTable.getTable().getColumnModel().getColumn(3).setPreferredWidth(225);
		tariffJTable.getTable().getColumnModel().getColumn(4).setPreferredWidth(100);
		tariffJTable.getTable().getColumnModel().getColumn(6).setPreferredWidth(90);
		
		aditPanel = new JPanel(new BorderLayout());
		aditPanel.add(tariffJTable);
		showPages(offSize, 1);
		aditPanel.add(box, BorderLayout.SOUTH);
		
		aditPanel.setBorder(new TitledBorder(null, "", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		aditPanel.setBounds(9, 111, 794, 416);
		aditPanel.repaint();
		getContentPane().add(aditPanel);
		
		tariffJTable.setBounds(10, 11, 695, 277);
		tariffJTable.setFont(new Font("Tahoma", Font.PLAIN, 11));
		tariffJTable.getTable().addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent me) {
                JTable table =(JTable) me.getSource();
                Point p = me.getPoint();
                int selectedRow = table.rowAtPoint(p);
                System.out.println(selectedRow);
                if (me.getClickCount() == 1 && selectedRow != -1) {
                	try {
						Connection conn = DBPool.getConnection();
					    RCTariff item = RCTariffDAO.get(conn, (Integer)tariffJTable.getTable().getValueAt(selectedRow, 0));
	                	if(item != null)
	                	{
	                		Item product = new Item(item.getProductId(), item.getProductName());
	                		OfferName = product.getName();
	                		//cbProduct.setSelectedIndex(listItem.indexOf(product));
	                		cbProduct.setSelectedItem(new ComboItem(product.getName(), product.getId().toString()));
	                		Item type = new Item(item.getTypeId(),item.getTypeName());
	                		cbType.setSelectedIndex(listTypeRC.indexOf(type) + 1);
	                		TypeName = type.getName();
	                		
	                		Item status = new Item(item.getStatusId(),item.getStatusName());
	                		cbStatus.setSelectedIndex(listStatusRC.indexOf(status) + 1);
	                		StatusName = status.getName();
	                				                		
	                	    btnDelete.setEnabled(true);
	                	    btnUpdate.setEnabled(true);
	                	    
	                		Id = (Integer)tariffJTable.getTable().getValueAt(selectedRow, 0);
	                		day = (Integer)tariffJTable.getTable().getValueAt(selectedRow,1);
	                		value = (Integer)tariffJTable.getTable().getValueAt(selectedRow, 5);
	                		fullcycle = (Boolean)tariffJTable.getTable().getValueAt(selectedRow,6);
	                	
	                	}
					} catch (SQLException e) {
						JOptionPane.showMessageDialog(frame, "Error proccess");
					}
                	
                }
            }
        });
		
		
	}
	
	public static void updateTable(){
		try{
			Connection conn = DBPool.getConnection();
			int offerId=0;
			int typeId=0;
			int statusId=0;
			
			ComboItem productItem = getComboItemFromValue(cbProduct.getSelectedItem().toString());
			System.out.println();
			if(productItem != null){
				offerId = Integer.parseInt(productItem.getValue());
			}else{
				JOptionPane.showMessageDialog(new JFrame(), MessageConstants.RC_TARIFF.PRODUCT_NOT_FOUND, "Error",  JOptionPane.ERROR_MESSAGE);
				cbProduct.requestFocus();
				return;
			}
				
			if(cbType.getSelectedIndex() != 0)
			{
				ComboItem item = (ComboItem) cbType.getSelectedItem();
				typeId= Integer.parseInt(item.getValue());
			}
			if(cbStatus.getSelectedIndex() != 0)
			{
				ComboItem item = (ComboItem) cbStatus.getSelectedItem();
				statusId= Integer.parseInt(item.getValue());
			}
			
			listRCTariff = RCTariffDAO.getListSearchRCTariff(conn, offerId,typeId,statusId);
			
			
			size = listRCTariff.size();
			if(size > 0){
				Object[][] data = new Object[size][columnNames.length];
				for(int i = 0 ; i < size ; i ++){
					data[i][0] = listRCTariff.get(i).getId();
					data[i][1] = listRCTariff.get(i).getDay();
					data[i][2] = listRCTariff.get(i).getProductName();
					data[i][3] = listRCTariff.get(i).getTypeName();
					data[i][4] = listRCTariff.get(i).getStatusName();
					data[i][5] = listRCTariff.get(i).getValue();
					data[i][6] = listRCTariff.get(i).getFullCycle()==1?true:false;
				
				}
				//MyTableModel tableModel = new MyTableModel();
				//tableModel.setColumnNames(columnNames);
				model.setData(data);
				tariffJTable.getTable().setModel(model);
				showPages(offSize, 1);
				tariffJTable.repaint();
				tariffJTable.setFont(new Font("Tahoma", Font.PLAIN, 11));
				tariffJTable.getTable().getColumnModel().getColumn(2).setPreferredWidth(300);
				tariffJTable.getTable().getColumnModel().getColumn(3).setPreferredWidth(200);
			}else{
				resetToEmptyTable();
			}
		}catch(SQLException e)
		{
			e.printStackTrace();
		}

	}
	
	
	public static void resetToEmptyTable(){
		model.setData(null);
		tariffJTable.getTable().setModel(model);
		tariffJTable.repaint();
		showPages(offSize, 1);
	}
	
	public void searchTable(){
		try{
			Connection conn = DBPool.getConnection();
			int offerId=0;
			int typeId=0;
			int statusId=0;
			ComboItem productItem = getComboItemFromValue(cbProduct.getSelectedItem().toString());
			if(productItem == null){
				/*JOptionPane.showMessageDialog(frame, MessageConstants.RC_TARIFF.PRODUCT_NOT_FOUND, "Error",  JOptionPane.ERROR_MESSAGE);
				cbProduct.requestFocus();
				return;*/
				resetToEmptyTable();
				return;
			}else{
				offerId = Integer.parseInt(productItem.getValue());
			}
			
			if(cbType.getSelectedIndex()!=0)
			{
				ComboItem item = (ComboItem) cbType.getSelectedItem();
				typeId= Integer.parseInt(item.getValue());
			}
			if(cbStatus.getSelectedIndex()!=0)
			{
				ComboItem item = (ComboItem) cbStatus.getSelectedItem();
				statusId= Integer.parseInt(item.getValue());
			}
			
			listRCTariff  = RCTariffDAO.getListSearchRCTariff(conn, offerId,typeId,statusId);
			size = listRCTariff.size();
			
			
			
			if(size > 0 && cbType.getSelectedIndex()!=0 &&  cbStatus.getSelectedIndex()!=0){
				Object[][] data = new Object[size][columnNames.length];
				for(int i = 0 ; i < size ; i ++){
					data[i][0] = listRCTariff.get(i).getId();
					data[i][1] = listRCTariff.get(i).getDay();
					data[i][2] = listRCTariff.get(i).getProductName();
					data[i][3] = listRCTariff.get(i).getTypeName();
					data[i][4] = listRCTariff.get(i).getStatusName();
					data[i][5] = listRCTariff.get(i).getValue();
					data[i][6] = listRCTariff.get(i).getFullCycle()==1?true:false;
				}
				model.setData(data);
				tariffJTable.getTable().setModel(model);
				tariffJTable.setFont(new Font("Tahoma", Font.PLAIN, 11));
				tariffJTable.getTable().getColumnModel().getColumn(2).setPreferredWidth(300);
				tariffJTable.getTable().getColumnModel().getColumn(3).setPreferredWidth(200);
				tariffJTable.repaint();
				showPages(offSize, 1);
				repaint();
			}else{
				resetToEmptyTable();
			}
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
	
	}
	
	public void setRowValue(String day, String productname, String typeId,String statusId,String value,Boolean fullcycle){
         cbProduct.setSelectedItem(productname);
	
	}

	@SuppressWarnings("unchecked")
	public static void showPages(final int itemsPerPage, final int currentPageIndex) {
		ArrayList<JRadioButton> list = new ArrayList<JRadioButton>();
		sorter.setRowFilter(filter(itemsPerPage, currentPageIndex - 1));
		int startPageIndex = currentPageIndex - pageSize;
		if (startPageIndex <= 0)
			startPageIndex = 1;
		int maxPageIndex = (model.getRowCount() / itemsPerPage) + 1;
		int endPageIndex = currentPageIndex + pageSize - 1;
		if (endPageIndex > maxPageIndex)
			endPageIndex = maxPageIndex;

		if (currentPageIndex > 1)
			list.add(createRadioButtons(itemsPerPage, currentPageIndex - 1,
					"Prev"));
		for (int i = startPageIndex; i <= endPageIndex; i++)
			list.add(createLinks(itemsPerPage, currentPageIndex, i - 1));
		if (currentPageIndex < maxPageIndex)
			list.add(createRadioButtons(itemsPerPage, currentPageIndex + 1,
					"Next"));

		box.removeAll();
		
		JPanel a = new JPanel();
		a.setLayout(null);
		currentTotal = currentPageIndex * itemsPerPage;
		currentTotal = (currentTotal >= model.getRowCount()) ? model.getRowCount() : currentTotal;
		totalLabel = new JLabel("Total Record: " + String.valueOf(currentTotal) + "/" + String.valueOf(model.getRowCount())) ;
		totalLabel.setBounds(79, 1, 133, 20);
		a.add(totalLabel);
		a.setPreferredSize(new Dimension(350,20));
		box.add(a);
		comboBox = new JComboBox();
		comboBox.setBounds(0, 3, 69, 17);
		a.add(comboBox);
		comboBox.setModel(new DefaultComboBoxModel(new String[] {"20", "30", "40", "50", "100"}));
		comboBox.setSelectedItem(String.valueOf(offSize));
		comboBox.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent event) {
                JComboBox comboBox = (JComboBox) event.getSource();
                String selected = comboBox.getSelectedItem().toString();
                offSize = Integer.parseInt(selected);
                showPages(offSize, 1);
            }
        });
		
		
		
		ButtonGroup bg = new ButtonGroup();
		box.add(Box.createHorizontalGlue());
		for (JRadioButton r : list) {
			box.add(r);
			bg.add(r);
		}
		
		
		
		
		box.revalidate();
		box.repaint();
		list.clear();
	}


	@SuppressWarnings("serial")
	private static JRadioButton createLinks(final int itemsPerPage, final int current,
			final int target) {
		    JRadioButton radio = new JRadioButton("" + (target + 1)) {
			protected void fireStateChanged() {
				ButtonModel model = getModel();
				if (!model.isEnabled()) {
					setForeground(Color.GRAY);
				} else if (model.isPressed() && model.isArmed()) {
					setForeground(Color.GREEN);
				} else if (model.isSelected()) {
					setForeground(Color.RED);
				}
				super.fireStateChanged();
			}
		};
		radio.setForeground(Color.BLUE);
		radio.setUI(ui);
		if (target + 1 == current) {
			radio.setSelected(true);
		}
		radio.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				showPages(itemsPerPage, target + 1);
			}
		});
		return radio;
	}

	private static JRadioButton createRadioButtons(final int itemsPerPage,
			final int target, String title) {
		JRadioButton radio = new JRadioButton(title);
		radio.setForeground(Color.BLUE);
		radio.setUI(ui);
		radio.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				showPages(itemsPerPage, target);
			}
		});
		return radio;
	}

	@SuppressWarnings("rawtypes")
	private static RowFilter filter(final int itemsPerPage, final int target) {
		return new RowFilter() {
			public boolean include(Entry entry) {
				int ei = (Integer) entry.getIdentifier();
				return (target * itemsPerPage <= ei && ei < target
						* itemsPerPage + itemsPerPage);
			}
		};
	}
	
	public static ComboItem getComboItemFromValue(String key){
		if(StringUtils.isEmpty(key)){
			return null;
		}
		for(Item i : listItem){
			if(i.getName().equalsIgnoreCase(key)){
				return new ComboItem(i.getName(), i.getId().toString());
			}
		}
		return null;
	}
}
