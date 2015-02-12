/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.hotexport.data;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

import ElcRate.adapter.jdbc.JDBCInputAdapter;
import ElcRate.exception.InitializationException;
import ElcRate.exception.ProcessingException;
import ElcRate.logging.ILogger;
import ElcRate.record.DBRecord;
import ElcRate.record.FlatRecord;
import ElcRate.record.IRecord;
import ElcRate.record.TrailerRecord;
import ElcRate.utils.PropertyUtils;
import eonerate.hotexport.entity.RateRecord;
import eonerate.hotexport.util.LogUtil;

public class DBInputAdapter extends JDBCInputAdapter {

	// -------------------------------------------------------
	ILogger LOG_PROCESSING = ElcRate.logging.LogUtil.getLogUtil().getLogger("Processing");

	private static final long DEFAULT_HEADER_ID = 0;
	// The buffer size is the size of the buffer in the buffered reader
	private static final int BUF_SIZE = 65536;
	// ---
	private static final String HOT_TABLE_SUFFIX = "HotTableSuffix";
	private static final String OUTPUT_FILE_PATH = "OutputFilePath";
	private static final String OUTPUT_FILE_PREFIX = "OutputFilePrefix";
	private static final String OUTPUT_FILE_SUFFIX = "OutputFileSuffix";
	private static final String ERR_FILE_PATH = "ErrFilePath";
	private static final String ERR_FILE_PREFIX = "ErrFilePrefix";
	private static final String ERR_FILE_SUFFIX = "ErrFileSuffix";
	private static final String PROCESSING_SUFFIX = "ProcessingSuffix";

	private long headerId;
	private String hotTableSuffix = "hot1";
	private String outputFilePath = "data";
	private String outputFilePrefix = "hrc.";
	private String outputFileSuffix = ".csv";
	private String processingPrefix = ".doing";

	private String outputFileDoingName;
	private String outputFileName;

	//	private boolean existedDoingCdrFile = false;
	// -------------------------------------------------------

	// This is the stream record number counter which tells us the number of
	// the compressed records
	private int StreamRecordNumber = 0;
	// This is the object that is used to compress the records
	RateRecord tmpDataRecord = null;

	private boolean theFirst = true;

	public DBInputAdapter() {
		//Nothing
	}

	@Override
	public void init(String PipelineName, String ModuleName) throws InitializationException {
		super.init(PipelineName, ModuleName);

		// !!!
		readCfg();

		createDataFolder();

		//		readHeaderId();
		//		checkExistDoingFile();
	}

	@Override
	public IRecord procHeader(IRecord r) {
		StreamRecordNumber = 0;
		return r;
	}

	@Override
	public IRecord procValidRecord(IRecord r) {
		DBRecord originalRecord = (DBRecord) r;
		FlatRecord tmpOutRecord = new FlatRecord();
		tmpDataRecord = new RateRecord(originalRecord.getOriginalColumns());
		BufferedWriter validWriter;

		tmpDataRecord.mapVNPRecord();

		// Return the created record
		StreamRecordNumber++;
		tmpDataRecord.RecordNumber = StreamRecordNumber;

		tmpOutRecord.setData(tmpDataRecord.unmapOriginalData());

		// -----
		headerId = Long.parseLong(tmpDataRecord.CDR_RECORD_HEADER_ID);

		if (theFirst) {
			deleteExistedFile();
			theFirst = false;
		}

		if (/*!existedDoingCdrFile*/StreamRecordNumber == 1) {
			createDoingCdrFile();
		}

		//		writeHeaderId();

		try {

			// write the record to file
			File file = new File(outputFileDoingName);
			FileWriter fwriter = new FileWriter(file, true);
			validWriter = new BufferedWriter(fwriter, BUF_SIZE);

			validWriter.write(tmpOutRecord.getData());
			validWriter.newLine();
			validWriter.flush();
			validWriter.close();

		} catch (IOException ioex) {
			this.getExceptionHandler().reportException(new ProcessingException(ioex, getSymbolicName()));
		} catch (Exception ex) {
			this.getExceptionHandler().reportException(new ProcessingException(ex, getSymbolicName()));
		}
		// -----

		return tmpDataRecord;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) {
		return r;
	}

	@Override
	public IRecord procTrailer(IRecord r) {
		TrailerRecord tmpTrailer;

		// set the trailer record count
		tmpTrailer = (TrailerRecord) r;
		tmpTrailer.setRecordCount(StreamRecordNumber);

		File oldFile = new File(outputFileDoingName);
		File newFile = new File(outputFileName);
		//		oldFile.renameTo(newFile);

		Path from = oldFile.toPath(); //convert from File to Path
		Path to = newFile.toPath(); // Paths.get(strTarget); //convert from String to Path
		try {
			Files.copy(from, to, StandardCopyOption.REPLACE_EXISTING);
			Files.deleteIfExists(from);

			LOG_PROCESSING.info(LogUtil.logFormatPipeSymbolic(getPipeName(), getSymbolicName(), "DONE: Move Doing output file: " + outputFileDoingName + " -> " + outputFileName));
		} catch (IOException e) {
			LOG_PROCESSING.error("Cannot move file: " + outputFileDoingName + " -> " + outputFileName);
		}

		//		existedDoingCdrFile = false;

		return (IRecord) tmpTrailer;
	}

	// -------------------------------------------------------	

	//	private void writeHeaderId() {
	//		PrintWriter out;
	//		try {
	//			out = new PrintWriter(getHeaderIdFilePath());
	//
	//			out.println(headerId);
	//
	//			out.flush();
	//			out.close();
	//		} catch (FileNotFoundException e) {
	//			this.getExceptionHandler().reportException(new ProcessingException(e, getSymbolicName()));
	//		}
	//	}

	private String getDataFolder() {
		return outputFilePath + System.getProperty("file.separator") + hotTableSuffix;
	}

	private void createDataFolder() {
		File f = new File(getDataFolder());
		if (!f.mkdirs()) {
			System.err.println("Cannot create data folder: " + getDataFolder());
		}
	}

	//	private void checkExistDoingFile() {
	//		File directory = new File(getDataFolder());
	//
	//		File[] fList = directory.listFiles();
	//		for (File file : fList) {
	//			String name = file.getName();
	//
	//			if (name.startsWith(outputFilePrefix) && name.endsWith("." + headerId + processingPrefix)) {
	//				outputFileDoingName = file.getAbsolutePath();
	//				LOG_PROCESSING.info(LogUtil.logFormatPipeSymbolic(getPipeName(), getSymbolicName(), "DONE: Set existed doing output file: " + outputFileDoingName));
	//
	//				outputFileName = outputFileDoingName.substring(0, outputFileDoingName.length() - processingPrefix.length());
	//				LOG_PROCESSING.info(LogUtil.logFormatPipeSymbolic(getPipeName(), getSymbolicName(), "DONE: Set existed output file: " + outputFileName));
	//
	//				existedDoingCdrFile = true;
	//
	//				break;
	//			}
	//		}
	//	}

	private void deleteExistedFile() {
		String doingFileName;
		String doneFileName;

		File directory = new File(getDataFolder());

		File[] fList = directory.listFiles();
		for (File file : fList) {
			String name = file.getName();

			if (name.startsWith(outputFilePrefix) && name.endsWith("." + headerId + outputFileSuffix + processingPrefix)) {
				doingFileName = file.getAbsolutePath();

				try {
					if (Files.deleteIfExists(file.toPath())) {
						LOG_PROCESSING.info(LogUtil.logFormatPipeSymbolic(getPipeName(), getSymbolicName(), "DONE: Delete existed doing output file: " + doingFileName));
					}
				} catch (IOException e) {
					LOG_PROCESSING.error(LogUtil.logFormatPipeSymbolic(getPipeName(), getSymbolicName(), "FAILED: Delete existed doing output file: " + doingFileName));
				}

				break;
			}

			if (name.startsWith(outputFilePrefix) && name.endsWith("." + headerId + outputFileSuffix)) {

				doneFileName = file.getAbsolutePath();

				try {
					if (Files.deleteIfExists(file.toPath())) {
						LOG_PROCESSING.info(LogUtil.logFormatPipeSymbolic(getPipeName(), getSymbolicName(), "DONE: Delete existed doing output file: " + doneFileName));
					}
				} catch (IOException e) {
					LOG_PROCESSING.error(LogUtil.logFormatPipeSymbolic(getPipeName(), getSymbolicName(), "FAILED: Delete existed doing output file: " + doneFileName));
				}

				break;

			}
		}
	}

	//	private void readHeaderId() {
	//		try {
	//			File source = new File(getHeaderIdFilePath());
	//
	//			if (!source.exists()) {
	//				PrintWriter out = new PrintWriter(new FileOutputStream(getHeaderIdFilePath()));
	//				out.println(DEFAULT_HEADER_ID);
	//				out.flush();
	//				out.close();
	//
	//				headerId = DEFAULT_HEADER_ID;
	//			} else {
	//				Scanner scanner = new Scanner(source);
	//				headerId = scanner.nextLong();
	//				scanner.close();
	//			}
	//
	//			LOG_PROCESSING.info(LogUtil.logFormatPipeSymbolic(getPipeName(), getSymbolicName(), "DONE: Read HeaderId from ConfigFile (" + getHeaderIdFilePath() + "): " + headerId));
	//
	//		} catch (Exception ex) {
	//			System.err.println("Couldn't init headerId with file: " + getHeaderIdFilePath());
	//			this.getExceptionHandler().reportException(new ProcessingException(ex, getSymbolicName()));
	//			System.exit(1);
	//		}
	//	}

	//	private String getHeaderIdFilePath() {
	//		return "configData/" + hotTableSuffix + "." + "headerid.txt";
	//	}

	/**
	 * Tao ra file doing, ghi File header len file doing nay
	 */
	private void createDoingCdrFile() {

		BufferedWriter validWriter = null;

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date now = Calendar.getInstance().getTime();

		outputFileName = getDataFolder() + System.getProperty("file.separator") +
				outputFilePrefix + dateFormat.format(now) + "." + headerId + outputFileSuffix;
		outputFileDoingName = getDataFolder() + System.getProperty("file.separator") +
				outputFilePrefix + dateFormat.format(now) + "." + headerId + outputFileSuffix + processingPrefix;

		try {
			File doingFile = new File(outputFileDoingName);
			//			File doneFile = new File(outputFileName);

			//			if (doingFile.exists()) {
			//				Files.delete(doingFile.toPath());
			//			}
			//
			//			if (doneFile.exists()) {
			//				Files.delete(doneFile.toPath());
			//			}

			FileWriter fwriter = new FileWriter(doingFile, false);
			validWriter = new BufferedWriter(fwriter, BUF_SIZE);

			validWriter.write(StringUtils.EMPTY);

			validWriter.flush();
			validWriter.close();

			LOG_PROCESSING.info(LogUtil.logFormatPipeSymbolic(getPipeName(), getSymbolicName(), "DONE: Create new doing output file: " + outputFileDoingName));

			//			existedDoingCdrFile = true;
		} catch (IOException e) {
			this.getExceptionHandler().reportException(new ProcessingException(e, getSymbolicName()));
		}
	}

	private void readCfg() throws InitializationException {
		hotTableSuffix = PropertyUtils.getPropertyUtils().getBatchInputAdapterPropertyValueDef(
				super.getPipeName(),
				super.getSymbolicName(),
				HOT_TABLE_SUFFIX,
				"None");

		if ((hotTableSuffix == null) || hotTableSuffix.equalsIgnoreCase("None"))
		{
			message = "DBInputAdapter config error. " + HOT_TABLE_SUFFIX + " property not found.";
			getPipeLog().error(message);
			throw new InitializationException(message, getSymbolicName());
		}

		//
		outputFilePath = PropertyUtils.getPropertyUtils().getBatchInputAdapterPropertyValueDef(
				super.getPipeName(),
				super.getSymbolicName(),
				OUTPUT_FILE_PATH,
				"None");

		if ((outputFilePath == null) || outputFilePath.equalsIgnoreCase("None"))
		{
			message = "DBInputAdapter config error. " + OUTPUT_FILE_PATH + " property not found.";
			getPipeLog().error(message);
			throw new InitializationException(message, getSymbolicName());
		}

		//
		outputFilePrefix = PropertyUtils.getPropertyUtils().getBatchInputAdapterPropertyValueDef(
				super.getPipeName(),
				super.getSymbolicName(),
				OUTPUT_FILE_PREFIX,
				"None");

		if ((outputFilePrefix == null) || outputFilePrefix.equalsIgnoreCase("None"))
		{
			message = "DBInputAdapter config error. " + OUTPUT_FILE_PREFIX + " property not found.";
			getPipeLog().error(message);
			throw new InitializationException(message, getSymbolicName());
		}

		//
		outputFileSuffix = PropertyUtils.getPropertyUtils().getBatchInputAdapterPropertyValueDef(
				super.getPipeName(),
				super.getSymbolicName(),
				OUTPUT_FILE_SUFFIX,
				"None");

		if ((outputFileSuffix == null) || outputFileSuffix.equalsIgnoreCase("None"))
		{
			message = "DBInputAdapter config error. " + OUTPUT_FILE_SUFFIX + " property not found.";
			getPipeLog().error(message);
			throw new InitializationException(message, getSymbolicName());
		}

		//
		processingPrefix = PropertyUtils.getPropertyUtils().getBatchInputAdapterPropertyValueDef(
				super.getPipeName(),
				super.getSymbolicName(),
				PROCESSING_SUFFIX,
				"None");

		if ((processingPrefix == null) || processingPrefix.equalsIgnoreCase("None"))
		{
			message = "DBInputAdapter config error. " + PROCESSING_SUFFIX + " property not found.";
			getPipeLog().error(message);
			throw new InitializationException(message, getSymbolicName());
		}
	}
}
