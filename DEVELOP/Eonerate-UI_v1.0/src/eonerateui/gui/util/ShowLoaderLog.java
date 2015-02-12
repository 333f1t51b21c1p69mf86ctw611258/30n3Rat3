package eonerateui.gui.util;

import java.awt.BorderLayout;
import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Font;
import javax.swing.JTextArea;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import javax.swing.border.LineBorder;
import java.awt.Color;
import javax.swing.JScrollPane;


@SuppressWarnings("serial")
public class ShowLoaderLog extends JFrame {
	private JButton btnClose;
	private JTextArea textArea;
	private JScrollPane scrollPane;

	/**
	 * Create the dialog.
	 */
	public ShowLoaderLog(String title, String logFile) {
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setTitle(title);
		setBounds(100, 100, 793, 464);
		setLocationRelativeTo(null);
		getContentPane().setLayout(new BorderLayout());
		{
			JPanel buttonPane = new JPanel();
			FlowLayout fl_buttonPane = new FlowLayout(FlowLayout.CENTER);
			buttonPane.setLayout(fl_buttonPane);
			getContentPane().add(buttonPane, BorderLayout.SOUTH);
			{
				btnClose = new JButton("Close log file");
				btnClose.addActionListener(new ActionListener() {
					public void actionPerformed(ActionEvent e) {
						ShowLoaderLog.this.dispose();
					}
				});
				btnClose.setFont(new Font("Tahoma", Font.PLAIN, 11));
				btnClose.setActionCommand("OK");
				buttonPane.add(btnClose);
				getRootPane().setDefaultButton(btnClose);
			}
		}
		{
			textArea = new JTextArea();
			textArea.setBorder(new LineBorder(new Color(0, 0, 0)));
			textArea.setEditable(false);
			textArea.setFont(new Font("Courier New", Font.PLAIN, 13));
			getContentPane().add(textArea, BorderLayout.CENTER);
			{
				scrollPane = new JScrollPane(textArea);
				getContentPane().add(scrollPane, BorderLayout.CENTER);
			}
			
			loadLogFile(logFile);
		}
	}
	
	private void loadLogFile(String logFile) {
		try {
	       	FileReader reader = new FileReader(logFile);
			textArea.read(reader,logFile);
			
		} catch (FileNotFoundException e) {
			textArea.append("File '" + logFile + "' not found!");
			System.out.println("java.io.FileNotFoundException :" + e.getMessage());
		} catch (IOException e) {
			textArea.append(e.getMessage());
			System.out.println("java.io.FileNotFoundException :" + e.getMessage());
		}
	}
}
