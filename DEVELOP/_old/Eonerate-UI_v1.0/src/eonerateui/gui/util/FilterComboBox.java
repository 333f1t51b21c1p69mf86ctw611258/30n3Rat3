package eonerateui.gui.util;

import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.DefaultComboBoxModel;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;

import eonerateui.db.RCTariffDAO;
import eonerateui.db.pool.DBPool;
import eonerateui.util.Item;

public class FilterComboBox extends JComboBox {
    /**
	 * 
	 */
	private static final long serialVersionUID = -4957276763022886297L;
	private List<Item> array;
    public FilterComboBox(List<Item> array) {
       // super(array.toArray());
        this.array = array;
        this.setEditable(true);
        final JTextField textfield = (JTextField) this.getEditor().getEditorComponent();
        textfield.addKeyListener(new KeyAdapter() {
            public void keyTyped(KeyEvent ke) {
                SwingUtilities.invokeLater(new Runnable() {
                    public void run() {
                        comboFilter(textfield.getText());
                    }
                });
            }
        });

    }

    public void comboFilter(String enteredText) {
        List<String> filterArray= new ArrayList<String>();
        for (int i = 0; i < array.size(); i++) {
            if (array.get(i).getName().toLowerCase().contains(enteredText.toLowerCase())) {
                filterArray.add(array.get(i).getName());
            }
        }
        if (filterArray.size() > 0) {
            this.setModel(new DefaultComboBoxModel(filterArray.toArray()));
            this.setSelectedItem(enteredText);
            this.showPopup();
        }
        else {
            this.hidePopup();
        }
    }
    
    public void comboFilter1(String enteredText) {
        if (!this.isPopupVisible()) {
            this.showPopup();
        }

        List<String> filterArray= new ArrayList<String>();
        for (int i = 0; i < array.size(); i++) {
            if (array.get(i).getName().toLowerCase().contains(enteredText.toLowerCase())) {
                filterArray.add(array.get(i).getName());
            }
        }
        if (filterArray.size() > 0) {
            DefaultComboBoxModel model = (DefaultComboBoxModel) this.getModel();
            model.removeAllElements();
            for (String s: filterArray)
                model.addElement(s);

            JTextField textfield = (JTextField) this.getEditor().getEditorComponent();
            textfield.setText(enteredText);
        }
    }
    

    /* Testing Codes */
    public static List<String> populateArray() {
        List<String> test = new ArrayList<String>();
        test.add("");
        test.add("Mountain Flight");
        test.add("Mount Climbing");
        test.add("Trekking");
        test.add("Rafting");
        test.add("Jungle Safari");
        test.add("Bungie Jumping");
        test.add("Para Gliding");
        return test;
    }

    public static void makeUI() {
    	ArrayList<Item> listItem = new ArrayList<Item>();
    	Connection conn;
		try {
			conn = DBPool.getConnection();
			listItem = RCTariffDAO.getListProduct(conn);
	        JFrame frame = new JFrame("Adventure in Nepal - Combo Filter Test");
	        FilterComboBox acb = new FilterComboBox(listItem);
	        Item empty = new Item(0, "");
	        listItem.add(0, empty);
	        for(Item i : listItem){
	        	acb.addItem(new ComboItem( i.getName(),i.getId().toString()));
	        }
	        frame.getContentPane().add(acb);
	        frame.pack();
	        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	        frame.setVisible(true);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
    }

    public static void main(String[] args) throws Exception {

        //UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        makeUI();
    }
}