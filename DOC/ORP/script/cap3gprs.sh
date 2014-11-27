#!/bin/bash

# ORP parameters
HOST=offline

#Session parameters
ANUM=841258464320
TIME="2 hours ago"
DURA=600
VOL=1048576
APN=m3-mms
QOS=1001
A1129=0 # 0=MS-initiated, 1=network-initiated

# Network parameters
MSCID=8491020467
SGSNID=8491020467
LN=84910100401999 # Vinaphone_LN

####################################################

# Get record sequence
RSEQ=`cat orp.seq`
if [ -z $RSEQ ]; then
  RSEQ=1
fi
echo $(($RSEQ + 1)) > orp.seq

# lookup INITIAL_AUT
KEY="${APN}_${QOS}="
IAUT=`grep ^$KEY gprs.map | cut -f2 -d=`
if [ -z $IAUT ]; then
  echo "Error: Could not lookup APN/QOS $APN/$QOS pair"
  exit 1
fi

# Generate record template
echo "RECORD_TYPE=GPR" > tmp
printf 'RECORD_SEQUENCE=%010d\n' $RSEQ >> tmp
echo "ACTIVITY_TYPE=2" >> tmp
echo "RECORD_ORIGIN=$HOST" >> tmp

TT=`date -d "$TIME" +%s`
echo "OFFERED_TIME=$TT" >> tmp
echo "ANSWERED_TIME=$TT" >> tmp
echo "DISC_TIME=$(($TT + $DURA))" >> tmp

echo "A_NUM=$ANUM" >> tmp
echo "NOA=0" >> tmp
echo "NPI=1" >> tmp
echo "EXTERNAL_ID=$ANUM" >> tmp
echo "EXTERNAL_ID_TYPE=1" >> tmp

echo "ORIGIN=0" >> tmp # 0=network, 1=roaming, 2=URE
echo "SGSN=$SGSNID" >> tmp
echo "MSC_ID=$LN" >> tmp
#echo "CELL_ID=$CELLID" >> tmp
#echo "CP_LAI=$CELLID" >> tmp
echo "CRN=1$RSEQ" >> tmp

echo "APP_TYPE=-1" >> tmp # 10=GPRS
echo "SUBTYPE=-1" >> tmp
echo "UNIT_TYPE=3" >> tmp # 3=octet
echo "RESERVATION_TYPE=1" >> tmp # 1=volume-based
echo "PDP_INIT_TYPE=$A1129" >> tmp
echo "CALL_TYPE=0" >> tmp # 0=regular call, 2=forwarded call

echo "INITIAL_AUT=$IAUT" >> tmp # aut_initial_values.initial_aut_id (30017=GPRSVolume)
echo "CLEAR_CAUSE=400" >> tmp
echo "APN=$APN" >> tmp
echo "QOS=$QOS" >> tmp
echo "CONS_AMOUNT=$VOL" >> tmp

echo "UTC_OFFSET=420" >> tmp

echo "BILLABLE=1" >> tmp
#if [ "$A1129" == 0 ]; then
#  echo "CP_CALLTYPE=87" >> tmp # 87=CAP3_MS_ORIGINATING_GPRS
#else
#  echo "CP_CALLTYPE=88" >> tmp # 88=CAP3_NETWORK_ORIGINATING_GPRS
#fi
echo "EXT_SEQUENCE=$RSEQ" >> tmp

/usr/bin/expect -f orp_rec | tee -a cdr.dat
