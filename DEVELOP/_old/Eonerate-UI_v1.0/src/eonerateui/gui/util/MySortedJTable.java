
/**
 * @TODO This is used to implement a sorting JTable
 * 
 * 
 * @author Son.Pham.Hong
 * @date 25 Nov 2013 
 */

package eonerateui.gui.util;

import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;


@SuppressWarnings("serial")
public class MySortedJTable extends JPanel {
    public JTable table;

	public MySortedJTable(MyTableModel tableModel) {
        super(new GridLayout(1,0));

        table = new ZebraJTable(tableModel);
        table.setPreferredScrollableViewportSize(new Dimension(500, 70));
        table.setFillsViewportHeight(true);
        table.setAutoCreateRowSorter(true);

        //Create the scroll pane and add the table to it.
        JScrollPane scrollPane = new JScrollPane(table);

        //Add the scroll pane to this panel.
        add(scrollPane);
       
        ((DefaultTableCellRenderer)table.getTableHeader().getDefaultRenderer()).setHorizontalAlignment(JLabel.CENTER);
        table.getTableHeader().setFont(new Font("Trebuchet MS", Font.BOLD, 13));
        table.setFont(new Font("Tahoma", Font.PLAIN, 13));
        table.setRowHeight(20);
        
    }

	public JTable getTable() {
		return table;
	}

	public void setTable(JTable table) {
		this.table = table;
	}
    
}
