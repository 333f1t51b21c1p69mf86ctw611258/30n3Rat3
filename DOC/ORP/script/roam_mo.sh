#!/bin/bash

# ORP parameters
HOST=offline

# Call parameters
ANUM=841258464320
BNUM=6084904567890
TIME="2 hours ago"
DURA=$(($RANDOM % 300 + 10))

# Network parameters
. network.vnp

# Roaming location
VISITCODE=66

####################################################

if [ $VISITCODE -eq 66 ]; then
  CELLID=52001
else
  echo "Unknown visit code $VISITCODE"
  exit
fi

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
#echo "RESULT_CODE=0" >> tmp
#echo "RESULT_TEXT=OR_RSLT_UNPROCESSED(0)" >> tmp
echo "RECORD_ORIGIN=$HOST" >> tmp

TT=`date -d "$TIME" +%s`
echo "OFFERED_TIME=$TT" >> tmp # for roaming, offer and answer time are the same
echo "ANSWERED_TIME=$TT" >> tmp
echo "DISC_TIME=$(($TT + $DURA))" >> tmp

echo "A_NUM=$ANUM" >> tmp
echo "B_NUM=00$BNUM" >> tmp
echo "NOA=0" >> tmp
echo "NPI=1" >> tmp
echo "EXTERNAL_ID=$ANUM" >> tmp
echo "EXTERNAL_ID_TYPE=1" >> tmp
echo "B_EXT_ID_TYPE=1" >> tmp

echo "ORIGIN=1" >> tmp # 0=network, 1=roaming, 2=URE
echo "CELL_ID=$CELLID" >> tmp
echo "CRN=1$RSEQ" >> tmp

echo "APP_TYPE=-1" >> tmp
echo "SUBTYPE=-1" >> tmp
echo "UNIT_TYPE=2" >> tmp # 2=seconds, 4=sms
echo "CALL_TYPE=0" >> tmp # 0=regular call, 2=forwarded call
echo "INITIAL_AUT=30012" >> tmp # aut_initial_values.initial_aut_id (30012=Voice, 30016=CAP3SMS)
echo "CLEAR_CAUSE=16" >> tmp

echo "UTC_OFFSET=420" >> tmp

/usr/bin/expect -f orp_rec | tee -a cdr.dat
