package eonerateui.gui.menu.help;

import javax.swing.ImageIcon;
import javax.swing.JDialog;
import javax.swing.JLabel;
import java.io.*;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

@SuppressWarnings("serial")
public class About extends JDialog {

	/**
	 * Create the dialog.
	 * @throws IOException 
	 */
	public About() throws IOException {
		setModalityType(ModalityType.DOCUMENT_MODAL);
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setResizable(false);
		setTitle("About eOneRate");
		setBounds(100, 100, 450, 300);
		setLocationRelativeTo(null);

		String path = "images/About.jpg";
        File file = new File(path);
        BufferedImage image = ImageIO.read(file);
        JLabel label = new JLabel(new ImageIcon(image));

        getContentPane().add(label);
        pack();

	}
}
