#!/bin/bash

# ORP parameters
HOST=slu1

# Call parameters
ANUM=841258464320
BNUM=0084904385538
TIME="3 hours ago"
DURA=$(($RANDOM % 300 + 10))

# Network parameters
MSCID=8491020467
CELLID=84910100401999 # Vinaphone_LN

####################################################

TT=`date -d "$TIME" +%H:%M:%S`
echo "$TT, $ANUM calls $BNUM, $DURA seconds"

# Get record sequence
RSEQ=`cat orp.seq`
if [ -z $RSEQ ]; then
  RSEQ=1
fi
echo $(($RSEQ + 1)) > orp.seq

# Generate record template
echo "RECORD_TYPE=VOI" > tmp
printf 'RECORD_SEQUENCE=%010d\n' $RSEQ >> tmp
echo "ACTIVITY_TYPE=0" >> tmp
echo "RESULT_CODE=0" >> tmp
echo "RESULT_TEXT=OR_RSLT_UNPROCESSED(0)" >> tmp
echo "RECORD_ORIGIN=$HOST" >> tmp

TT=`date -d "$TIME" +%s`
echo "OFFERED_TIME=$(($TT - 5))" >> tmp
echo "ANSWERED_TIME=$TT" >> tmp
echo "DISC_TIME=$(($TT + $DURA))" >> tmp

echo "A_NUM=$ANUM" >> tmp
echo "B_NUM=$BNUM" >> tmp
echo "NOA=0" >> tmp
echo "NPI=1" >> tmp
echo "EXTERNAL_ID=$ANUM" >> tmp
echo "EXTERNAL_ID_TYPE=1" >> tmp
echo "B_EXT_ID_TYPE=1" >> tmp

echo "ORIGIN=0" >> tmp # 0=network, 1=roaming, 2=URE
echo "MSC_ID=$MSCID" >> tmp
echo "CELL_ID=$CELLID" >> tmp
echo "CP_LAI=$CELLID" >> tmp
echo "CRN=1$RSEQ" >> tmp

echo "APP_TYPE=1" >> tmp
echo "SUBTYPE=0" >> tmp
echo "UNIT_TYPE=2" >> tmp # 2=seconds, 4=sms
echo "CALL_TYPE=0" >> tmp # 0=regular call, 2=forwarded call
echo "INITIAL_AUT=30012" >> tmp # aut_initial_values.initial_aut_id (30012=Voice, 30016=CAP3SMS)
echo "CLEAR_CAUSE=16" >> tmp

echo "UTC_OFFSET=420" >> tmp
echo "CP_TIMEZONE=420" >> tmp

echo "BILLABLE=1" >> tmp
#echo "CP_INDICATOR=-1" >> tmp
echo "CP_POSTPAID_TYPE=1" >> tmp # 0=CV postpaid, 1=non-CV postpaid, 2=Prepaid
echo "CP_CALLTYPE=52" >> tmp # 52=OPPS, 86=CAP3SMS-MO
echo "CP_CALL_DIRECTION=O" >> tmp
#echo "CP_CHARGE_INDICATOR=0" >> tmp
#echo "TYPE_1_NORM_NUM=$BNUM" >> tmp
#echo "TYPE_2_NORM_NUM=$BNUM" >> tmp
#echo "CP_NCF_LEG=-" >> tmp
#echo "CONS_AMOUNT=0" >> tmp
#echo "ORG_CHARGE_AMT=0" >> tmp

#TT=`date +%s`
#orfile=`printf 'IPor.%010d.%s.%04d.bill' $TT $HOST $RSEQ`
#printf 'ORH %s%010d%010d|%010d|%010d|%010d\n' $HOST $RSEQ $RSEQ $TT $TT 1 > $orfile
/usr/bin/expect -f orp_rec | tee -a cdr.dat
