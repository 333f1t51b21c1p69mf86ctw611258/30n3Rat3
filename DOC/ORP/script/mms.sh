#!/bin/bash

# ORP parameters
HOST=offline

# MMS parameters
ANUM=841258464320
BNUM=0084904385538
TIME="3 hours ago"
MTYPE=TEXT # TEXT or MEDIA

####################################################

if [ $MTYPE == "MEDIA" ]; then
  IAUT=30033
else
  IAUT=30031
fi

###################################################

TT=`date +%H:%M:%S -d "$TIME"`
echo "$TT, $ANUM sms $BNUM"

# Get record sequence
RSEQ=`cat orp.seq`
if [ -z $RSEQ ]; then
  RSEQ=1
fi
echo $(($RSEQ + 1)) > orp.seq

# Generate record template
echo "RECORD_TYPE=SMS" > tmp
printf 'RECORD_SEQUENCE=%010d\n' $RSEQ >> tmp
echo "ACTIVITY_TYPE=3" >> tmp
echo "RECORD_ORIGIN=$HOST" >> tmp

TT=`date -d "$TIME" +%s`
echo "OFFERED_TIME=$TT" >> tmp
echo "ANSWERED_TIME=$TT" >> tmp
echo "DISC_TIME=$TT" >> tmp

echo "A_NUM=$ANUM" >> tmp
echo "B_NUM=$BNUM" >> tmp
echo "NOA=0" >> tmp
echo "NPI=1" >> tmp
echo "EXTERNAL_ID=$ANUM" >> tmp
echo "EXTERNAL_ID_TYPE=1" >> tmp

echo "ORIGIN=0" >> tmp # 0=network, 1=roaming, 2=URE
echo "CRN=1$RSEQ" >> tmp

echo "APP_TYPE=-1" >> tmp
echo "SUBTYPE=-1" >> tmp
echo "UNIT_TYPE=4" >> tmp # 2=seconds, 4=sms
echo "CALL_TYPE=0" >> tmp # 0=regular call, 2=forwarded call
echo "INITIAL_AUT=$IAUT" >> tmp
echo "CLEAR_CAUSE=16" >> tmp

echo "ECI_MSG_TYPE=APPLYTARIFF_MSG" >> tmp
echo "ECI_ASSOCIATED_NUMBER=$RSEQ" >> tmp
echo "ECI_TRANS_ID1=$RSEQ" >> tmp
echo "ECI_TRANS_ID2=$RSEQ" >> tmp

#echo "ECI_MSISDN=$ANUM" >> tmp
#echo "ECI_ALT_MSISDN=$BNUM" >> tmp
#echo "ECI_SUBSCR_TYPE=BOTH_SUBSCRIBERS" >> tmp
#echo "ECI_BEARER_CAP=" >> tmp

echo "UTC_OFFSET=420" >> tmp
echo "EXT_SEQUENCE=$RSEQ" >> tmp

/usr/bin/expect -f orp_rec | tee -a cdr.dat
