package eonerateui.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SecurityUtils {

	public static String encryptedPass(String username, String password) {
		try{
			String encryptedKey = ProgramConfig.getEncryptedKey();
			return md5(username + password + encryptedKey);
		}catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
			return "";
		}
	}

	public static String md5(String input)
    {
        MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
			md.update(input.getBytes());
	        byte byteData[] = md.digest();
	        //convert the byte to hex format method 1
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < byteData.length; i++) {
	         sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	        }
	        return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			System.out.println("Exception: " + e.getMessage());
			return "";
		}
    }
	
	public static void main(String args[]){
		System.out.println(encryptedPass("sonph", "123456"));
	}
}
