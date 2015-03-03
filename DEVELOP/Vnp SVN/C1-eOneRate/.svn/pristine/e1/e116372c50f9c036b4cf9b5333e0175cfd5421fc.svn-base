/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.orptransformation.ORPRecords;

import ElcRate.record.ErrorType;
import ElcRate.record.RatingRecord;
import ElcRate.record.RecordError;
import ElcRate.utils.StringUtils;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class OrpRecord extends RatingRecord
{

    public static final int NUMBER_OF_FIELDS = 138;
    public static final String FIELD_SPLITTER = "|";
    public static final int VOICE_DURATION=1;
    DecimalFormat df = new DecimalFormat("0000000000");

    public static final int GPRS = 1;
    public static final int MMS = 2;
    public static final int OCG_SMPP = 31;
    public static final int OCG_XML = 30;
    public static final int SDP = 4;
    public static final int TAP_MOC_TNC = 50; // goi trong nuoc
    public static final int TAP_MOC_QTE=51;   // goi quoc te
    public static final int TAP_SMSMO = 52;
    public static final int TAP_SMSMT = 53;
    public static final int TAP_MTC = 54;
    public static final int TAP_GPRS = 55;
    public static final int PORTAL = 6;
    public static final int QTAN = 7;
    public static final int VMS = 8;
    public static final int MEG_VOICE = 90;
    public static final int MEG_SMS = 91;

    //GPRS index
    public static final int GPRS_CDR_TYPE_IDX = 0;
    public static final int GPRS_MSISDN_IDX = 1;
    public static final int GPRS_RECORD_OPENING_TIME_IDX = 2;
    public static final int GPRS_ACCESS_POINT_NAME_NI_IDX = 3;
    public static final int GPRS_CHARGING_CLASS_IDX = 4;
    public static final int GPRS_DATA_VOLUME_UPLINK_IDX = 5;
    public static final int GPRS_DATA_VOLUME_DOWNLINK_IDX = 6;
    public static final int GPRS_DURATION_IDX = 7;
    public static final int GPRS_PLMN_ID_IDX = 8;

    //MMS index
    public static final int MMS_CDR_TYPE_IDX = 0;
    public static final int MMS_MSISDN_IDX = 1;
    public static final int MMS_B_NUMBER_IDX = 2;
    public static final int MMS_RECORD_OPENING_TIME_IDX = 3;
    public static final int MMS_ATTACH_IDX = 4;

    //OCG SMMP
    public static final int OCG_SMPP_CDR_TYPE_IDX = 0;
    public static final int OCG_SMPP_A_NUMBER_IDX = 1;
    public static final int OCG_SMPP_SHORT_CODE_IDX = 2;
    public static final int OCG_SMPP_RECORD_OPENING_TIME_IDX = 3;

    //OCG XML
    public static final int OCG_XML_CDR_TYPE_IDX = 0;
    public static final int OCG_XML_A_NUMBER_IDX = 1;
    public static final int OCG_XML_B_NUMBER_IDX = 2;
    public static final int OCG_XML_RECORD_OPENING_TIME_IDX = 3;
    public static final int OCG_XML_CONTENT_ID_IDX = 4;
    public static final int OCG_XML_SUB_CONTENT_ID_IDX = 5;

    //SDP
    public static final int SDP_CDR_TYPE_IDX = 0;
    public static final int SDP_MSISDN_IDX = 1;
    public static final int SDP_RECORD_OPENING_TIME_IDX = 2;
    public static final int SDP_PRODUCT_ID_IDX = 3;
    public static final int SDP_SPID_IDX = 4;

    //PORTAL
    public static final int PORTAL_CDR_TYPE_IDX = 0;
    public static final int PORTAL_A_NUMBER_IDX  = 1;
    public static final int PORTAL_B_NUMER_IDX = 2;
    public static final int PORTAL_RECORD_OPENING_TIME_IDX = 3;
    public static final int PRODUCT_ID_IDX = 4;
    public static final int SPID_IDX = 5;

    //QTAN
    public static final int QTAN_CDR_TYPE_IDX = 0;
    public static final int QTAN_RECORD_OPENING_TIME_IDX = 1;
    public static final int QTAN_RECORD_CLOSINING_TIME_IDX = 2;
    public static final int QTAN_A_NUMBER_IDX = 3;
    public static final int QTAN_B_NUMBER_IDX = 4;
    public static final int QTAN_REGISTERED_IDX = 5;

    //TAP GPRS
    public static final int TAP_GPRS_CDR_TYPE_IDX = 0;
    public static final int TAP_GPRS_RECORD_VN_OPENING_TIME_IDX = 1;
    public static final int TAP_GPRS_ISDN_IDX = 2;
    public static final int TAP_GPRS_IMSI_IDX = 3;
    //public static final int TAP_GPRS_CALL_TYPE_IDX = 4;
    public static final int TAP_GPRS_DURATION_IDX = 4;
    public static final int TAP_GPRS_VOLUME_UP_IDX = 5;
    public static final int TAP_GPRS_VOLUME_DOWN_IDX = 6;
    public static final int TAP_GPRS_CODE_IDX = 7;
    public static final int TAP_GPRS_PLMN_ID_IDX = 8;

    //TAP MOC
    public static final int TAP_MOC_CDR_TYPE_IDX = 0;
    public static final int TAP_MOC_RECORD_VN_OPENING_TIME_IDX = 1;
    public static final int TAP_MOC_ISDN_IDX = 2;
    public static final int TAP_MOC_IMSI_IDX = 3;
   // public static final int TAP_MOC_CALL_TYPE_IDX = 4;
    public static final int TAP_MOC_DURATION_IDX = 4;
    public static final int TAP_MOC_CALLING_NUMBER_IDX = 5;
    public static final int TAP_MOC_CALLED_NUMBER_IDX = 6;
    public static final int TAP_MOC_CALL_TYPE_LEVEL_IDX = 7;
    public static final int TAP_MOC_CODE_IDX = 8;
    public static final int TAP_MOC_PLMN_ID_IDX = 9;

    //TAP MTC
    public static final int TAP_MTC_CDR_TYPE_IDX = 0;
    public static final int TAP_MTC_RECORD_VN_OPENING_TIME_IDX = 1;
    public static final int TAP_MTC_ISDN_IDX = 2;
    public static final int TAP_MTC_IMSI_IDX = 3;
   // public static final int TAP_MTC_CALL_TYPE_IDX = 4;
    public static final int TAP_MTC_DURATION_IDX = 4;
    public static final int TAP_MTC_CALLING_NUMBER_IDX = 5;
    public static final int TAP_MTC_CALLED_NUMBER_IDX = 6;
    public static final int TAP_MTC_CALL_TYPE_LEVEL_IDX = 7;
    public static final int TAP_MTC_CODE_IDX = 8;
    public static final int TAP_MTC_PLMN_ID_IDX = 9;

    //TAP SMS MO
    public static final int TAP_SMS_CDR_TYPE_IDX = 0;
    public static final int TAP_SMS_RECORD_VN_OPENING_TIME_IDX = 1;
    public static final int TAP_SMS_ISDN_IDX = 2;
    public static final int TAP_SMS_IMSI_IDX = 3;
    //public static final int TAP_SMS_CALL_TYPE_IDX = 4;
    public static final int TAP_SMS_DURATION_IDX = 4;
    public static final int TAP_SMS_CALLING_NUMBER_IDX = 5;
    public static final int TAP_SMS_CALLED_NUMBER_IDX = 6;
    public static final int TAP_SMS_CALL_TYPE_LEVEL_IDX = 7;
    public static final int TAP_SMS_CODE_IDX = 8;
    public static final int TAP_SMS_PLMN_ID_IDX = 9;

    // Roaming Voice trong nuoc
    public static final int VMS_CDR_TYPE_IDX = 0;
    public static final int VMS_CALLING_NUMBER_IDX = 1;
    public static final int VMS_CALLED_NUMBER_IDX = 2;
    public static final int VMS_RECORD_VN_OPENING_TIME_IDX = 3;
    public static final int VMS_DURATION_IDX = 4;
    public static final int VMS_REC_TYPE_IDX = 5;
    public static final int VMS_LAC_IDX = 6;
    public static final int VMS_CELLID_IDX = 7;

    // MEG VOICE
    public static final int MEG_VOICE_CDR_TYPE_IDX = 0;
    public static final int MEG_VOICE_CALLING_NUMBER_IDX = 1;
    public static final int MEG_VOICE_CALLED_NUMBER_IDX = 2;
    public static final int MEG_VOICE_RECORD_VN_OPENING_TIME_IDX = 3;
    public static final int MEG_VOICE_DURATION_IDX = 4;
    public static final int MEG_VOICE_MSC_IDX = 5;

    //MEG SMS
    public static final int MEG_SMS_CDR_TYPE_IDX = 0;
    public static final int MEG_SMS_CALLING_NUMBER_IDX = 1;
    public static final int MEG_SMS_CALLED_NUMBER_IDX = 2;
    public static final int MEG_SMS_RECORD_VN_OPENING_TIME_IDX = 3;
    public static final int MEG_VOICE_RATE_IDX = 4;

    
   
    //ORP parameter
    public String RecordType = "";
    public String RecordSequenceNumber = "";
    public String ActivityType = "";
    public String ResultCode = "";
    public String ResultText = "";
    public String Reserved1 = "";
    public String Reserved2 = "";
    public String RecordOrigin = "";
    public String ActivityOfferedDateTime = "";
    public String ActivityAnsweredDateTime = "";
    public String ActivityDisconnectDateTime = "";
    public String ANumber = "";
    public String BNumber = "";
    public String ExternalId = "";
    public String ExternalIdtype = "";
    public String MSCID = "";
    public String MSRN = "";
    public String ApplicationType = "";
    public String Subtype = "";
    public String UnitType = "";
    public String ReferenceNumber = "";
    public String InitialAUT = "";
    public String ChargeType = "";
    public String SGSN = "";
    public String ClearCause = "";
    public String CellID = "";
    public String NetworkCalltype = "";
    public String ConsumedAmount = "";
    public String UTCOffset = "";
    public String Origin = "";
    public String PortedNumber = "";
    public String OriginalChargeAmount = "";
    public String OriginalChargeCurrency = "";
    public String GSMProviderID = "";
    public String APN = "";
    public String QOS = "";
    public String ReservationType = "";
    public String PDPInitType = "";
    public String ServiceIDCellIDLAI = "";
    public String ECIMessageType = "";
    public String ECIAssociatedNumber = "";
    public String ECIMISSIDN = "";
    public String ECIAltMISSIDN = "";
    public String ECISubscriberType = "";
    public String ECIBearerCapability = "";
    public String ECIApplicationID = "";
    public String ECITransactionID1 = "";
    public String ECITransactionID2 = "";
    public String ECIAccessMT = "";
    public String ECIMINtranslation = "";
    public String ECIChargeAmount = "";
    public String ECIProrate = "";
    public String ECISDPIDOrigin = "";
    public String ECIInforParam1 = "";
    public String ECIInforParam2 = "";
    public String CallProcessorCellIDLAI = "";
    public String CallProcessorPrePostIndicator = "";
    public String CallProcessorPOSTPAIDType = "";
    public String CallProcessorCallType = "";
    public String CallProcessorNetworkNoCharge = "";
    public String CallProcessorRedirectingNumber = "";
    public String CallProcessorMINIMSI = "";
    public String CallProcessorTranslatedDestinationNumber = "";
    public String CallProcessorApartyMSRN = "";
    public String CallProcessorNCFLeg = "";
    public String CallProcessorCallDirection = "";
    public String CallProcessorAnumberanswertime = "";
    public String CallProcessorBnumberanswertime = "";
    public String Billable = "";
    public String ExternalSystemSequenceNumber = "";
    public String OsaReservationStartTime = "";
    public String OsaReservationType = "";
    public String OsaSubscriberId = "";
    public String OsaParamItem = "";
    public String OsaParamSubtype = "";
    public String OsaParamConfirmationId = "";
    public String OsaParamContract = "";
    public String OsaTimezoneOffset = "";
    public String OsaParamQos = "";
    public String OsaParamService1 = "";
    public String OsaParamService2 = "";
    public String OsaParamService3 = "";
    public String OsaParamService4 = "";
    public String OsaParamInformational = "";
    public String OsaParamSubLocation = "";
    public String OsaParamSubLocationType = "";
    public String OsaParamOtherLocation = "";
    public String OsaParamOtherLocationType = "";
    public String OsaParamImsiMin = "";
    public String OsaMerchantId = "";
    public String OsaSessionDescription = "";
    public String OsaSessionID = "";
    public String OsaCorrelationId = "";
    public String OsaCorrelationType = "";
    public String OsaMerAccount = "";
    public String OsaApplDescText = "";
    public String OsaExtUnitTypeId = "";
    public String OsaCurrency = "";
    public String OsaReasonCode = "";
    public String OsaRequestType = "";
    public String Ocsapplication = "";
    public String Ocsapplicationdescription = "";
    public String Ocsspecialfeaturedigits = "";
    public String Ocsactivitytime = "";
    public String OcsRequesttype = "";
    public String OcsTBit = "";
    public String Ocsconsumedunits = "";
    public String Ocsconsumedunittype = "";
    public String Ocscurrencytype = "";
    public String Ocsimsinum = "";
    public String Ocschargeitemid = "";
    public String Ocssessiongid = "";
    public String Ocssubsessionid = "";
    public String Ocstransactionid = "";
    public String Ocssubscriberid = "";
    public String Ocssessiondesc = "";
    public String Ocssublocation = "";
    public String Ocssublocationtype = "";
    public String Ocssubotherlocation = "";
    public String Ocssubotherlocationtype = "";
    public String Ocsteleservicetype = "";
    public String CallprocessorTimeZone = "";
    public String Offereddtmsec = "";
    public String Answereddtmsec = "";
    public String Disconnectdtmsec = "";
    public String PointTargetExternalIdType = "";
    public String NetworkPortingPrefix = "";
    public String IMSIA = "";
    public String IMSIB = "";
    public String type1NormalizedNumber = "";
    public String type2NormalizedNumber = "";
    public String CallingNumberPresentation = "";
    public String networkaddressplan = "";
    public String Ocssegmentid = "";
    public String CpIncomingCallid = "";
    public String CpOutgoingcallid = "";
    public String OcsStartCallDatTimeType = "";
    public String OcsEndCallDatTimeType = "";

     // Digit
    
    public static final String DIGIT="^\\d+$";
    public static final String SPACE="^\\s+$";
    
    //For lookup Roaming
    public String PartnerCode = "";
    //For lookup SDP
    public String SDPProductID = "";
    public String SDPSPID = "";
    
    //For enrich BNumber
    public String DialedDigit="";
    
    //For lookup OCG
    public String ShortCode="";
    

    public OrpRecord()
    {
        super();
    }

    public void mapGPRSRecord(String OriginalData)
    {
        RecordError tmpError;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date tmpDate;
        long tmpLongDate = 0;
        long tmpDuration = 0;

        this.OriginalData = OriginalData;
        this.RECORD_TYPE = GPRS;
        this.RecordType = "GPR";
        
      
        this.fields = OriginalData.split("\\,");
        if (fields.length<9)
           
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
        
        //check if any fields is null
        
        for (int count=0;count<9;count++)
        { 
            if (("").equals(getField(count))|| getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                return;
               
            }
        }
        
        //Get fields values from input CDR
        ANumber = getField(GPRS_MSISDN_IDX);
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        try
        {
            tmpDate = sdfInput.parse(getField(GPRS_RECORD_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;

        //APN processing
        APN = getField(GPRS_ACCESS_POINT_NAME_NI_IDX);
        try
        {

            APN = APN.substring(0, APN.indexOf("."));

        }
        catch (StringIndexOutOfBoundsException ex)
        {
            APN=getField(GPRS_ACCESS_POINT_NAME_NI_IDX);
        }

        //QOS processing
        QOS = getField(GPRS_CHARGING_CLASS_IDX).replaceFirst("^0+(?!$)", "");

        //Data volume processing
        String tmpDataUplink = getField(GPRS_DATA_VOLUME_UPLINK_IDX);
        String tmpDataDownlink = getField(GPRS_DATA_VOLUME_DOWNLINK_IDX);

        try
        {
            ConsumedAmount = String.valueOf(Long.valueOf(tmpDataUplink) + Long.valueOf(tmpDataDownlink));

        }
        catch (Exception ex)
        {
            tmpError = new RecordError("ERR_DATA_VOLUME_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        // Parse the duration
        try
        {
            tmpDuration = Long.valueOf(getField(GPRS_DURATION_IDX));
        }
        catch (NumberFormatException nfe)
        {
            tmpDuration = 0;
            tmpError = new RecordError("ERR_DURATION_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + tmpDuration);

        //Inital values
        RecordSequenceNumber = "0000000000";
        ActivityType = "2";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        ApplicationType = "-1";
        Subtype = "-1";
        UnitType = "3";
        ReferenceNumber = "0";
        InitialAUT = "30039";//temporary values
        ClearCause = "400";
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
        ReservationType = "1";
        PDPInitType = "0";
        Billable = "1";
        networkaddressplan = "1";
        RecordOrigin = "offline";

    }

    public void mapMMSRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate;
        int attachValue=0;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        this.RECORD_TYPE = MMS;
        this.RecordType = "SMS";
        this.fields = OriginalData.split("\\,");
        
        if (fields.length<5)
           
        {      
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
        
        //check if any fields is null
        
        for (int count=0;count<5;count++)
        { 
            if (("").equals(getField(count))||getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                return;
            }
        }
        
        //Get fields values from input CDR
        ANumber = getField(MMS_MSISDN_IDX);

        DialedDigit = getField(MMS_B_NUMBER_IDX);
        try
        {
            DialedDigit = DialedDigit.substring(0, DialedDigit.indexOf("/"));
        }
        catch (IndexOutOfBoundsException ex)
        {
            DialedDigit = DialedDigit.substring(0, DialedDigit.indexOf("@"));
        }
        catch (Exception ep)
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }; 
        
        try
        {
            tmpDate = sdfInput.parse(getField(MMS_RECORD_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;
        ActivityDisconnectDateTime = ActivityOfferedDateTime;
        
        try {
            attachValue = Integer.parseInt(getField(MMS_ATTACH_IDX));
        
        } catch (Exception ee) {
            
            tmpError = new RecordError("ERR_ATTACH_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        //Inital values
        ActivityType = "3";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        ApplicationType = "2";
        Subtype = "0";
        UnitType = "4";
        if (attachValue > 0)
        {
            InitialAUT = "30033";
        }
        else
        {
            InitialAUT = "30031";
        }
        ClearCause = "16";
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
        ECIMessageType = "APPLYTARIFF_MSG";
        ECIAssociatedNumber = "0";
        ECITransactionID1 = ANumber;
        ECITransactionID2 = ActivityOfferedDateTime;

    }

    public void mapOCGSMPPRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        this.RECORD_TYPE = OCG_SMPP;
        this.RecordType = "VOI";
        this.fields = OriginalData.split("\\,");
        
        if (fields.length<4)
           
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
        
        //check if any fields is null

        for (int count=0;count<4;count++)
        { 
            if (("").equals(getField(count))||getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                break;
            }
        }
        
        //Get fields values from input CDR
        ANumber = getField(OCG_SMPP_A_NUMBER_IDX);
        ShortCode = getField(OCG_SMPP_SHORT_CODE_IDX);
        
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        if(!ShortCode.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_SHORTCODE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };

        try
        {
            tmpDate = sdfInput.parse(getField(OCG_SMPP_RECORD_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;
        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + VOICE_DURATION);

        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "0";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "8491020467";  // must lookup 
        ApplicationType = "-1";
        Subtype = "-1";
        UnitType = "2";
        ReferenceNumber = "0";
        InitialAUT = "30012";
        ClearCause = "16";
        CellID = "84910100401"; // must lookup
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
        CallProcessorCellIDLAI = "84910100401"; // must lookup
        // ExternalSystemSequenceNumber= RecordSequenceNumber;
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

    public void mapOCGXMLRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        this.RECORD_TYPE = OCG_XML;
        this.RecordType = "VOI";
        this.fields = OriginalData.split("\\,");
        
        if (fields.length<6)
           
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
        //check if any fields is null

        for (int count=0;count<6;count++)
        { 
            if (("").equals(getField(count))||getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                return;
            }
        }
        
        //Get fields values from input CDR
        ANumber = getField(OCG_XML_A_NUMBER_IDX);
        DialedDigit = getField(OCG_XML_B_NUMBER_IDX);
        
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        try
        {
            tmpDate = sdfInput.parse(getField(OCG_XML_RECORD_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;
        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + VOICE_DURATION);
        //ActivityDisconnectDateTime = ActivityOfferedDateTime;

        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "0";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "8491020467";  // must lookup 
        ApplicationType = "-1";
        Subtype = "-1";
        UnitType = "2";
        ReferenceNumber = "0";
        InitialAUT = "30012";
        ClearCause = "16";
        CellID = "84910100401"; // must lookup
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
        CallProcessorCellIDLAI = "84910100401"; // must lookup
//            ExternalSystemSequenceNumber= RecordSequenceNumber;
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

    public void mapSDPRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        this.RECORD_TYPE = SDP;
        this.RecordType = "VOI";
        this.fields = OriginalData.split("\\,");
        
        if (fields.length<5)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
        //check if any fields is null

        for (int count=0;count<5;count++)
        { 
            if (("").equals(getField(count))||getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                return;
            }
        }
        //Get fields values from input CDR
        ANumber = getField(SDP_MSISDN_IDX);
        SDPProductID = getField(SDP_PRODUCT_ID_IDX);
        SDPSPID = getField(SDP_SPID_IDX).replaceFirst("^0+(?!$)", "");;
        //        DialedDigit=getField(SPD)            // need lookup
        // lay o dau ra DialedDigit=getField(SDP);
        
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        try
        {
            tmpDate = sdfInput.parse(getField(SDP_RECORD_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;
        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + VOICE_DURATION);
        //ActivityDisconnectDateTime = ActivityOfferedDateTime;

        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "0";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "8491020467";  // must lookup 
        ApplicationType = "-1";
        Subtype = "-1";
        UnitType = "2";
        ReferenceNumber = "0";
        InitialAUT = "30012";
        ClearCause = "16";
        CellID = "84910100401"; // must lookup
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
        CallProcessorCellIDLAI = "84910100401"; // must lookup
//            ExternalSystemSequenceNumber= RecordSequenceNumber;
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

    public void mapQTANRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        this.RECORD_TYPE = QTAN;
        this.RecordType = "VOI";
        this.fields = OriginalData.split("\\,");
        
         if (fields.length<6)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         //check if any fields is null

        for (int count=0;count<6;count++)
        { 
            if (("").equals(getField(count))||getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                return;
            }
        }
        
        //Get fields values from input CDR
        ANumber = getField(QTAN_A_NUMBER_IDX);
        
        ANumber = "84" + ANumber.substring(1, ANumber.length());
        DialedDigit = getField(QTAN_B_NUMBER_IDX);
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        try
        {
            tmpDate = sdfInput.parse(getField(QTAN_RECORD_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;
        
        // changed by DaoNH
        try
        {
            tmpDate = sdfInput.parse(getField(QTAN_RECORD_CLOSINING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityDisconnectDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
        }

        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "0";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "8491020467";  
        ApplicationType = "-1";
        Subtype = "-1";
        UnitType = "2";
        ReferenceNumber = "0";
        InitialAUT = "30012";
        ClearCause = "16";
        CellID = "84910100401"; 
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
        CallProcessorCellIDLAI = "84910100401"; 
        // ExternalSystemSequenceNumber= RecordSequenceNumber;
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

    public void mapPortalRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        this.RECORD_TYPE = PORTAL;
        this.RecordType = "CMS";
        this.fields = OriginalData.split("\\,");
        
         if (fields.length<4)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         //check if any fields is null

        for (int count=0;count<4;count++)
        { 
            if (("").equals(getField(count))||getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                break;
            }
        }
        
        //Get fields values from input CDR
        ANumber = getField(PORTAL_A_NUMBER_IDX);
        DialedDigit = getField(PORTAL_B_NUMER_IDX);
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        try
        {
            tmpDate = sdfInput.parse(getField(PORTAL_RECORD_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;
        ActivityDisconnectDateTime = ActivityOfferedDateTime;

        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "1";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "8491020467";   
        ApplicationType = "2";
        Subtype = "0";
        UnitType = "4";
        ReferenceNumber = "0";
        InitialAUT = "30016";
        ClearCause = "16";
        CellID = "849101004"; 
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
        //     CallProcessorCellIDLAI="84910100401"; // must lookup
        //     ExternalSystemSequenceNumber= RecordSequenceNumber;
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

    public void mapTAPGPRSRecord(String OriginalData)
    {
        RecordError tmpError;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date tmpDate;
        long tmpLongDate = 0;
        long tmpDuration = 0;
        this.RECORD_TYPE = TAP_GPRS;
        this.OriginalData = OriginalData;
        this.RecordType = "GPR";
        this.fields = OriginalData.split("\\,");
        
         if (fields.length<9)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         //check if any fields is null

//        for (int count=0;count<9;count++)
//        { 
//            if (("").equals(getField(count))||getField(count).matches(SPACE))
//            {
//                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
//                this.addError(tmpError);
//                return;
//            }
//        }
        //Get fields values from input CDR
        ANumber = getField(TAP_GPRS_ISDN_IDX);
        
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        try
        {
            tmpDate = sdfInput.parse(getField(TAP_GPRS_RECORD_VN_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;

        //Data volume processing
        String tmpDataUplink = getField(TAP_GPRS_VOLUME_UP_IDX);
        String tmpDataDownlink = getField(TAP_GPRS_VOLUME_DOWN_IDX);

        try
        {
            ConsumedAmount = String.valueOf(Long.valueOf(tmpDataUplink) + Long.valueOf(tmpDataDownlink));
            
        }
        catch (Exception ex)
        {
            tmpError = new RecordError("ERR_DATA_VOLUME_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        // Parse the duration
        try
        {
            tmpDuration = Long.valueOf(getField(TAP_GPRS_DURATION_IDX));
        }
        catch (NumberFormatException nfe)
        {
            tmpDuration = 0;
            tmpError = new RecordError("ERR_DURATION_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        //Partner code
        PartnerCode = getField(TAP_GPRS_CODE_IDX);

        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + tmpDuration);

        //Inital values
        RecordSequenceNumber = "0000000000";
        ActivityType = "2";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        ApplicationType = "10";
        Subtype = "30030";
        UnitType = "3";
        ReferenceNumber = "0";
        InitialAUT = "30047";   //temporary values
        SGSN = "52001";         //temporary values
        ClearCause = "400";
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "1";
        APN = "Vol_apn";       //temporary values
        QOS = "1";             //temporary values
        ReservationType = "1";
        PDPInitType = "0";
        CallingNumberPresentation="0";
        //ExternalSystemSequenceNumber=RecordSequenceNumber;
        networkaddressplan = "1";
        RecordOrigin = "offline";

    }

    public void mapTAPMOCRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate = 0;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        long tmpDuration;
        this.RECORD_TYPE=TAP_MOC_QTE;
      
        this.RecordType = "VOI";
        this.fields = OriginalData.split("\\,");
         if (fields.length<10)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         //check if any fields is null

//        for (int count=0;count<10;count++)
//        { 
//            if (("").equals(getField(count))||getField(count).matches(SPACE))
//            {
//                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
//                this.addError(tmpError);
//                return;
//            }
//        }
//        
         try
        {
            this.RECORD_TYPE = Integer.valueOf(getField(TAP_MOC_CDR_TYPE_IDX));
            
        }        
        catch (NumberFormatException nfe)
        {
            
            tmpError = new RecordError("ERR_DURATION_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         

        //Get fields values from input CDR
        ANumber = getField(TAP_MOC_ISDN_IDX);
        DialedDigit = getField(TAP_MOC_CALLED_NUMBER_IDX);
        
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        try
        {
            tmpDate = sdfInput.parse(getField(TAP_MOC_RECORD_VN_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;

        // Parse the duration
        try
        {
            tmpDuration = Long.valueOf(getField(TAP_MOC_DURATION_IDX));
        }
        catch (NumberFormatException nfe)
        {
            tmpDuration = 0;
            tmpError = new RecordError("ERR_DURATION_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
        PartnerCode = getField(TAP_MOC_CODE_IDX);

        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + tmpDuration);

        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "0";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "";  // must lookup 
        MSRN = "";
        ApplicationType = "-1";
        Subtype = "-1";
        UnitType = "2";
        ReferenceNumber = "0";
        InitialAUT = "30012";
        ClearCause = "16";
        CellID = "52001"; // must lookup
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "1";
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

    public void mapTAPMTCRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate = 0;
        long tmpDuration = 0;

        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        this.RECORD_TYPE = TAP_MTC;
        this.RecordType = "VOI";
        this.fields = OriginalData.split("\\,");
         if (fields.length<10)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         //check if any fields is null

//        for (int count=0;count<10;count++)
//        { 
//            if (("").equals(getField(count))||getField(count).matches(SPACE))
//            {
//                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
//                this.addError(tmpError);
//                return;
//            }
//        }
        //Get fields values from input CDR
        ANumber = getField(TAP_MTC_CALLING_NUMBER_IDX);
        if (ANumber==null||ANumber.isEmpty()){
            //Dummy number
            ANumber = "8491020005";
        }
        ANumber = "8491020005";
        
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
         DialedDigit = getField(TAP_MTC_ISDN_IDX);
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        try
        {
            tmpDate = sdfInput.parse(getField(TAP_MTC_RECORD_VN_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;

        // Parse the duration
        try
        {
            tmpDuration = Long.valueOf(getField(TAP_MTC_DURATION_IDX));
        }
        catch (NumberFormatException nfe)
        {
            tmpDuration = 0;
            tmpError = new RecordError("ERR_DURATION_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        PartnerCode = getField(TAP_MTC_CODE_IDX);

        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + tmpDuration);

        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "0";
        RecordOrigin = "offline";
        ExternalId =DialedDigit;
        ExternalIdtype = "1";
        MSCID = "";  // must lookup 
        MSRN = "";
        ApplicationType = "-1";
        Subtype = "-1";
        UnitType = "2";
        ReferenceNumber = "0";
        InitialAUT = "30012";
        ClearCause = "16";
        CellID = "52001"; // must lookup
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "1";
        CallingNumberPresentation = "0";
        networkaddressplan = "1";
        CallProcessorCallType = "53";
        CallProcessorCallDirection = "T";

    }

    public void mapTAPSMSMORecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate = 0;
        long tmpDuration = 0;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

        this.OriginalData = OriginalData;
        this.RECORD_TYPE = TAP_SMSMO;
        this.RecordType = "CMS";
        this.fields = OriginalData.split("\\,");
         if (fields.length<10)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         //check if any fields is null

//        for (int count=0;count<10;count++)
//        { 
//            if (("").equals(getField(count))||getField(count).matches(SPACE))
//            {
//                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
//                this.addError(tmpError);
//                return;
//            }
//        }
        //Get fields values from input CDR
        ANumber = getField(TAP_SMS_ISDN_IDX);
        DialedDigit = getField(TAP_SMS_CALLED_NUMBER_IDX);
        
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        try
        {
            tmpDate = sdfInput.parse(getField(TAP_SMS_RECORD_VN_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;

        // Parse the duration
        try
        {
            tmpDuration = Long.valueOf(getField(TAP_SMS_DURATION_IDX));
        }
        catch (NumberFormatException nfe)
        {
            tmpDuration = 0;
            tmpError = new RecordError("ERR_DURATION_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
        PartnerCode = getField(TAP_SMS_CODE_IDX);
        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + tmpDuration);

        //Inital values
        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "1";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "660000000";  // must lookup 
        ApplicationType = "2";
        Subtype = "0";
        UnitType = "4";
        ReferenceNumber = "0";
        InitialAUT = "30016";  // must lookup
        ClearCause = "16";
        CellID = "849101004"; // must lookup
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "1";
       // ExternalSystemSequenceNumber = RecordSequenceNumber;
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

    public void mapVMSRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate = 0;
        long tmpDuration;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        this.RECORD_TYPE = VMS;
        this.RecordType = "VOI";
        this.fields = OriginalData.split("\\,");
        
         if (fields.length<8)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         //check if any fields is null

        for (int count=0;count<8;count++)
        { 
            if (("").equals(getField(count))||getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                return;
            }
        }
        //Get fields values from input CDR
        ANumber = getField(VMS_CALLING_NUMBER_IDX);
        DialedDigit = getField(VMS_CALLED_NUMBER_IDX);
        
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        try
        {
            tmpDate = sdfInput.parse(getField(MEG_VOICE_RECORD_VN_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;
        try
        {
            tmpDuration = Long.valueOf(getField(MEG_VOICE_DURATION_IDX));
        }
        catch (NumberFormatException nfe)
        {
            tmpDuration = 0;
            tmpError = new RecordError("ERR_DURATION_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + tmpDuration);

        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "0";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "84900101011";  // must lookup 
        ApplicationType = "-1";
        Subtype = "-1";
        UnitType = "2";
        ReferenceNumber = "0";
        InitialAUT = "30012";
        ClearCause = "16";
        CellID = "84910100401"; // must lookup
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
        CallProcessorCellIDLAI = "84900202022"; // must lookup
        ExternalSystemSequenceNumber = RecordSequenceNumber;
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

    public void mapMEGVOICERecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate = 0;
        long tmpDuration;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.OriginalData = OriginalData;
        this.RECORD_TYPE = MEG_VOICE;
        this.RecordType = "VOI";
        this.fields = OriginalData.split("\\,");
        
         if (fields.length<6)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         //check if any fields is null

        for (int count=0;count<6;count++)
        { 
            if (("").equals(getField(count))||getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                return;
            }
        }
        //Get fields values from input CDR
        ANumber = getField(MEG_VOICE_CALLING_NUMBER_IDX);
        DialedDigit = getField(MEG_VOICE_CALLED_NUMBER_IDX);

        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        try
        {
            tmpDate = sdfInput.parse(getField(MEG_VOICE_RECORD_VN_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;
        try
        {
            tmpDuration = Long.valueOf(getField(MEG_VOICE_DURATION_IDX));
        }
        catch (NumberFormatException nfe)
        {
            tmpDuration = 0;
            tmpError = new RecordError("ERR_DURATION_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityDisconnectDateTime = String.valueOf(tmpLongDate + tmpDuration);

        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "0";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "8491020467";  // must lookup 
        ApplicationType = "-1";
        Subtype = "-1";
        UnitType = "2";
        ReferenceNumber = "0";
        InitialAUT = "30012";
        ClearCause = "16";
        CellID = "84910100401"; // must lookup
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
        CallProcessorCellIDLAI = "84910100401"; // must lookup
//            ExternalSystemSequenceNumber= RecordSequenceNumber;
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

    public void mapMEGSMSRecord(String OriginalData)
    {
        RecordError tmpError;
        Date tmpDate;
        long tmpLongDate = 0;
        long tmpDuration = 0;
        SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

        this.OriginalData = OriginalData;

        this.RECORD_TYPE = MEG_SMS;
        this.RecordType = "CMS";
        this.fields = OriginalData.split("\\,");
        
         if (fields.length<5)     
        {
            tmpError = new RecordError("ERR_NOT_ENOUGH_FIELD", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }
         //check if any fields is null

        for (int count=0;count<5;count++)
        { 
            if (("").equals(getField(count))||getField(count).matches(SPACE))
            {
                tmpError = new RecordError("ERR_BLANK_FIELD", ErrorType.DATA_VALIDATION);
                this.addError(tmpError);
                return;
            }
        }
        
        //Get fields values from input CDR
        ANumber = getField(MEG_SMS_CALLING_NUMBER_IDX);
        DialedDigit = getField(MEG_SMS_CALLED_NUMBER_IDX);
        
        if(!ANumber.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_ANUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        if(!DialedDigit.matches(DIGIT))
        {
            tmpError = new RecordError("ERR_BNUMBER_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        };
        try
        {
            tmpDate = sdfInput.parse(getField(MEG_SMS_RECORD_VN_OPENING_TIME_IDX));
            tmpLongDate = tmpDate.getTime() / 1000;
            ActivityOfferedDateTime = String.valueOf(tmpLongDate);

        }
        catch (ParseException ex)
        {
            tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
            this.addError(tmpError);
            return;
        }

        ActivityAnsweredDateTime = ActivityOfferedDateTime;
        ActivityDisconnectDateTime = ActivityOfferedDateTime;

        
        //Inital values
        RecordSequenceNumber = "0000000000"; // must generate
        ActivityType = "1";
        RecordOrigin = "offline";
        ExternalId = ANumber;
        ExternalIdtype = "1";
        MSCID = "8491020467";  // must lookup 
        //changed by quanght
        //ApplicationType = "-1";
        //Subtype = "-1";
        
        ApplicationType = "2";
        Subtype = "0";
        UnitType = "4";
        ReferenceNumber = "0";
        InitialAUT = "30016";  // must lookup
        ClearCause = "16";
        CellID = "849101004"; // must lookup
        NetworkCalltype = "0";
        UTCOffset = "420";
        Origin = "0";
//            ExternalSystemSequenceNumber= RecordSequenceNumber;
        CallingNumberPresentation = "0";
        networkaddressplan = "1";

    }

//    public String unmapOriginalData()
//    {
//        int NumberOfFields;
//        int i;
//        StringBuilder tmpReassemble;
//
//        tmpReassemble = new StringBuilder(1024);
//        NumberOfFields = this.fields.length;
//
//        for (i = 0; i < NumberOfFields; i++)
//        {
//
//            if (i == 0)
//            {
//                tmpReassemble.append(this.fields[i]);
//            }
//            else
//            {
//                tmpReassemble.append(",");
//                tmpReassemble.append(this.fields[i]);
//            }
//        }
//
//        return tmpReassemble.toString();
//    }

    public String unmapORPData(long startSequenceCDR)
    {
        int NumberOfFields;
        int i;
        StringBuilder tmpRecordData;

        tmpRecordData = new StringBuilder(1024);
        NumberOfFields = OrpRecord.NUMBER_OF_FIELDS;
        this.RecordSequenceNumber = df.format(startSequenceCDR);
        //this.ExternalSystemSequenceNumber=this.RecordSequenceNumber;
        tmpRecordData.append(this.RecordType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.RecordSequenceNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ActivityType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ResultCode);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ResultText);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Reserved1);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Reserved2);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.RecordOrigin);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ActivityOfferedDateTime);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ActivityAnsweredDateTime);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ActivityDisconnectDateTime);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ANumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.BNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ExternalId);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ExternalIdtype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.MSCID);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.MSRN);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ApplicationType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Subtype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.UnitType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ReferenceNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.InitialAUT);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ChargeType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.SGSN);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ClearCause);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CellID);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.NetworkCalltype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ConsumedAmount);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.UTCOffset);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Origin);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.PortedNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OriginalChargeAmount);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OriginalChargeCurrency);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.GSMProviderID);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.APN);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.QOS);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ReservationType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.PDPInitType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ServiceIDCellIDLAI);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIMessageType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIAssociatedNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIMISSIDN);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIAltMISSIDN);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECISubscriberType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIBearerCapability);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIApplicationID);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECITransactionID1);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECITransactionID2);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIAccessMT);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIMINtranslation);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIChargeAmount);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIProrate);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECISDPIDOrigin);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIInforParam1);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ECIInforParam2);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorCellIDLAI);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorPrePostIndicator);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorPOSTPAIDType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorCallType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorNetworkNoCharge);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorRedirectingNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorMINIMSI);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorTranslatedDestinationNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorApartyMSRN);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorNCFLeg);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorCallDirection);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorAnumberanswertime);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallProcessorBnumberanswertime);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Billable);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.ExternalSystemSequenceNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaReservationStartTime);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaReservationType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaSubscriberId);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamItem);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamSubtype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamConfirmationId);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamContract);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaTimezoneOffset);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamQos);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamService1);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamService2);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamService3);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamService4);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamInformational);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamSubLocation);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamSubLocationType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamOtherLocation);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamOtherLocationType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaParamImsiMin);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaMerchantId);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaSessionDescription);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaSessionID);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaCorrelationId);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaCorrelationType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaMerAccount);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaApplDescText);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaExtUnitTypeId);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaCurrency);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaReasonCode);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OsaRequestType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocsapplication);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocsapplicationdescription);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocsspecialfeaturedigits);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocsactivitytime);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OcsRequesttype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OcsTBit);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocsconsumedunits);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocsconsumedunittype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocscurrencytype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocsimsinum);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocschargeitemid);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocssessiongid);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocssubsessionid);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocstransactionid);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocssubscriberid);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocssessiondesc);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocssublocation);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocssublocationtype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocssubotherlocation);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocssubotherlocationtype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocsteleservicetype);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallprocessorTimeZone);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Offereddtmsec);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Answereddtmsec);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Disconnectdtmsec);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.PointTargetExternalIdType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.NetworkPortingPrefix);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.IMSIA);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.IMSIB);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.type1NormalizedNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.type2NormalizedNumber);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CallingNumberPresentation);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.networkaddressplan);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.Ocssegmentid);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CpIncomingCallid);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.CpOutgoingcallid);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OcsStartCallDatTimeType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);
        tmpRecordData.append(this.OcsEndCallDatTimeType);
        tmpRecordData.append(OrpRecord.FIELD_SPLITTER);

        return tmpRecordData.toString();
    }
    
    public String unmapOriginalData() {
        // just return the untampered with original
        return this.getOriginalData();
    }

    @Override
    public ArrayList<String> getDumpInfo()
    {

        ArrayList<String> tmpDumpList = null;
        tmpDumpList = new ArrayList<String>();
        return tmpDumpList;
    }
}
