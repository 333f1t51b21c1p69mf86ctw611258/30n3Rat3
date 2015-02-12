package eonerate.vnpcdrintegration.entity;

public class SftpLastest {

	public String slu;
	public String dateFolder;
	public long lastestCdrTime;

	/** 
	 * Su dung de merge tren DB
	 * 		changeFlag = false	=> Not change
	 * 		changeFlag = true	=> Insert or udpate
	 */
	public boolean changeFlag = false;

}
