package eonerate.cdrintegration.config;

public class MainConfig {

	public static MainConfig currentInstance;

	private String slus;
	private boolean deleteGzipFile;
	private String destFolderPath;
	private String inputHostName;
	private String inputUserName;
	private String inputPassword;
	private String inputDirectory;
	private String inputOsFileSeparator;
	private String outputOsFileSeparator;
	private int retryCount;
	private int retryDownloadFileSleepTime;
	private int scanInterval;
	private String dbConnection;
	private String dbUserName;
	private String dbPassword;
	private int corePoolSize;
	private int maximumPoolSize;
	private int instancePort;

	public String getSlus() {
		return slus;
	}

	public void setSlus(String slus) {
		this.slus = slus;
	}

	public boolean isDeleteGzipFile() {
		return deleteGzipFile;
	}

	public void setDeleteGzipFile(boolean deleteGzipFile) {
		this.deleteGzipFile = deleteGzipFile;
	}

	public String getDestFolderPath() {
		return destFolderPath;
	}

	public void setDestFolderPath(String destFolderPath) {
		this.destFolderPath = destFolderPath;
	}

	public String getInputHostName() {
		return inputHostName;
	}

	public void setInputHostName(String inputHostName) {
		this.inputHostName = inputHostName;
	}

	public String getInputUserName() {
		return inputUserName;
	}

	public void setInputUserName(String inputUserName) {
		this.inputUserName = inputUserName;
	}

	public String getInputPassword() {
		return inputPassword;
	}

	public void setInputPassword(String inputPassword) {
		this.inputPassword = inputPassword;
	}

	public String getInputDirectory() {
		return inputDirectory;
	}

	public void setInputDirectory(String inputDirectory) {
		this.inputDirectory = inputDirectory;
	}

	public String getInputOsFileSeparator() {
		return inputOsFileSeparator;
	}

	public void setInputOsFileSeparator(String inputOsFileSeparator) {
		this.inputOsFileSeparator = inputOsFileSeparator;
	}

	public String getOutputOsFileSeparator() {
		return outputOsFileSeparator;
	}

	public void setOutputOsFileSeparator(String outputOsFileSeparator) {
		this.outputOsFileSeparator = outputOsFileSeparator;
	}

	public int getRetryCount() {
		return retryCount;
	}

	public void setRetryCount(int retryCount) {
		this.retryCount = retryCount;
	}

	public int getRetryDownloadFileSleepTime() {
		return retryDownloadFileSleepTime;
	}

	public void setRetryDownloadFileSleepTime(int retryDownloadFileSleepTime) {
		this.retryDownloadFileSleepTime = retryDownloadFileSleepTime;
	}

	public int getScanInterval() {
		return scanInterval;
	}

	public void setScanInterval(int scanInterval) {
		this.scanInterval = scanInterval;
	}

	public String getDbConnection() {
		return dbConnection;
	}

	public void setDbConnection(String dbConnection) {
		this.dbConnection = dbConnection;
	}

	public String getDbUserName() {
		return dbUserName;
	}

	public void setDbUserName(String dbUserName) {
		this.dbUserName = dbUserName;
	}

	public String getDbPassword() {
		return dbPassword;
	}

	public void setDbPassword(String dbPassword) {
		this.dbPassword = dbPassword;
	}

	public int getCorePoolSize() {
		return corePoolSize;
	}

	public void setCorePoolSize(int corePoolSize) {
		this.corePoolSize = corePoolSize;
	}

	public int getMaximumPoolSize() {
		return maximumPoolSize;
	}

	public void setMaximumPoolSize(int maximumPoolSize) {
		this.maximumPoolSize = maximumPoolSize;
	}

	public int getInstancePort() {
		return instancePort;
	}

	public void setInstancePort(int instancePort) {
		this.instancePort = instancePort;
	}

}
