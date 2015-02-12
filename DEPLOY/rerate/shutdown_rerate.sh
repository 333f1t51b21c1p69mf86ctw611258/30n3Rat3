#!/bin/bash
export OR_ROOT_DIR=/home/oracle/tmp/abc/def/rerate
cd $OR_ROOT_DIR
java -Xmx128M -Xms128M -classpath ./eciClient.jar simpleclient.OpenRateClient localhost 8686 Framework:Shutdown=true
