/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.entity;

import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.record.ErrorType;
import ElcRate.record.RatingRecord;
import ElcRate.record.RecordError;
import eonerate.eciRemote.EciTelnetRemoter;
import java.io.IOException;
import java.util.ArrayList;
import org.apache.commons.lang.StringUtils;

/**
 *
 * @author manucian86
 */
public class RemoteRecord extends RatingRecord {

    ILogger LOG_ECI = LogUtil.getLogUtil().getLogger("ECI");
    //
    public static final int IDX_CMD_CODE = 0;
    public static final int IDX_COMMAND = 1;
    public static final int IDX_HOST_IP = 2;
    public static final int IDX_HOST_PORT = 3;
    //
    public Integer cmdCode;
    public String command;
    public String hostIp;
    public Integer hostPort;

    public RemoteRecord(String[] aFields) {
        super.fields = aFields;
    }

    public void mapRemoteRecord() {

        RecordError tmpError;

        try {
            String tmpCmdCode = getField(IDX_CMD_CODE);

            if (tmpCmdCode == null) {
                cmdCode = null;
            } else {
                cmdCode = Integer.valueOf(tmpCmdCode);
            }

        } catch (NumberFormatException nfe) {
            cmdCode = null;
            tmpError = new RecordError("ERR_CMD_CODE_INVALID; ERROR: " + nfe.toString(), ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
        }

        command = getField(IDX_COMMAND);
        if (StringUtils.isEmpty(command)) {
            tmpError = new RecordError("ERR_COMMAND_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
        }

        hostIp = getField(IDX_HOST_IP);
        if (StringUtils.isEmpty(command)) {
            tmpError = new RecordError("ERR_HOST_IP_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
        }

        try {
            String tmpHostPort = getField(IDX_HOST_PORT);

            if (tmpHostPort == null) {
                hostPort = null;
            } else {
                hostPort = Integer.valueOf(tmpHostPort);
            }

        } catch (NumberFormatException nfe) {
            hostPort = null;
            tmpError = new RecordError("ERR_HOST_PORT_INVALID; ERROR: " + nfe.toString(), ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
        }

        try {
            EciTelnetRemoter.remote(LOG_ECI, hostIp, hostPort, command);
        } catch (IOException ex) {
            tmpError = new RecordError("ERR_ECI_EXECUTION; ERROR: " + ex.toString(), ErrorType.SPECIAL);
            this.addError(tmpError);
        }

    }

    @Override
    public ArrayList<String> getDumpInfo() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
