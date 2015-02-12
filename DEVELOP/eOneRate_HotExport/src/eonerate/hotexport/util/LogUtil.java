package eonerate.hotexport.util;

public class LogUtil {
	public static String logFormatPipeSymbolic(String PipeName, String SymbolicName, String logMessage) {
		return "Pipe<" + PipeName + ";" + SymbolicName + "> - " + logMessage;
	}
}
