/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.orptransformation.adapter;

import ElcRate.adapter.file.FlatFileInputAdapter;
import ElcRate.record.ErrorType;
import ElcRate.record.FlatRecord;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import ElcRate.record.TrailerRecord;
import eonerate.orptransformation.ORPRecords.OrpRecord;

public class FileVNPInputAdapter extends FlatFileInputAdapter
{

    private int StreamRecordNumber;

    OrpRecord tmpDataRecord = null;
    RecordError tmpError;

    @Override
    public IRecord procHeader(IRecord r)
    {
        // reset the record numbering
        StreamRecordNumber = 0;

        return r;
    }

    @Override
    public IRecord procValidRecord(IRecord r)
    {
        String tmpData;
        int cdrtype=0;

        FlatRecord originalRecord = (FlatRecord) r;
        tmpData = originalRecord.getData();
        tmpDataRecord = new OrpRecord();
        tmpDataRecord.setOriginalData(tmpData);
        StreamRecordNumber++;
        tmpDataRecord.RecordNumber = StreamRecordNumber;
        try{
            cdrtype=Integer.valueOf(tmpData.split("\\,")[0]);
             
        }catch(Exception pe){
            getPipeLog().error("Error data input "+pe.toString());
            tmpError = new RecordError("ERR_CDR_TYPE_INVALID", ErrorType.DATA_VALIDATION);
            tmpDataRecord.addError(tmpError);
            
            return (IRecord) tmpDataRecord;
        }
        
        switch (cdrtype)
        {
            case 1:
            {
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapGPRSRecord(tmpData);
            }
            break;

            case 2:
            {
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapMMSRecord(tmpData);
            }
            break;

            case 30:
            {
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapOCGXMLRecord(tmpData);
            }
            break;

            case 31:
            {
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapOCGSMPPRecord(tmpData);
            }
            break;

            case 4:
            {
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapSDPRecord(tmpData);
            }
            break;

            case 50:
            {
                //Roaming goi trong nuoc
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapTAPMOCRecord(tmpData);
            }
            break;

            case 51:
            {
                //Roaming goi quoc te
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapTAPMOCRecord(tmpData);

            }
            break;

            case 52:
            {
                //Roaming gui tin nhan
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapTAPSMSMORecord(tmpData);
            }
            break;

            case 53:
            {
                //Roaming nhan tin nhan
                tmpError = new RecordError("ERR_CDR_TYPE_INVALID", ErrorType.DATA_VALIDATION);
                tmpDataRecord.addError(tmpError);
            }
            break;

            case 54:
            {
                //Roaming nhan cuoc goi
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapTAPMTCRecord(tmpData);
            }
            break;

            case 55:
            {
                //Roaming GPRS
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapTAPGPRSRecord(tmpData);
            }
            break;

            case 6:
            {
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapPortalRecord(tmpData);
            }
            break;

            case 7:
            {
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapQTANRecord(tmpData);
            }
            break;

            case 8:
            {
                //roaming trong nuoc
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapVMSRecord(tmpData);
            }
            break;

            case 90:
            {
                // meg voice
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapMEGVOICERecord(tmpData);
            }
            break;

            case 91:

            {
                // meg sms
//                tmpDataRecord = new OrpRecord();
                tmpDataRecord.mapMEGSMSRecord(tmpData);
            }
            break;
            
            default:
            {
                tmpError = new RecordError("ERR_CDR_TYPE_INVALID", ErrorType.DATA_VALIDATION);
                tmpDataRecord.addError(tmpError);
                
                return (IRecord) tmpDataRecord;
            }
        
        }
              
           
        return (IRecord) tmpDataRecord;
    }
    

    @Override
    public IRecord procErrorRecord(IRecord r)
    {

        // The FlatFileInputAdapter is not able to create error records, so we
        // do not have to do anything for this
        return r;
    }

    @Override
    public IRecord procTrailer(IRecord r)
    {
        TrailerRecord tmpTrailer;

        // set the trailer record count
        tmpTrailer = (TrailerRecord) r;

        tmpTrailer.setRecordCount(StreamRecordNumber);
        return (IRecord) tmpTrailer;
    }

}
