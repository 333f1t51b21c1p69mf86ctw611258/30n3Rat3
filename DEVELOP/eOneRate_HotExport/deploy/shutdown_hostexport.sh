#!/bin/bash
export OR_ROOT_DIR=./ # /home/eonerate/deploy/hotexport
cd $OR_ROOT_DIR
java -Xmx128M -Xms128M -classpath ./eciClient.jar simpleclient.OpenRateClient localhost 8068 Framework:Shutdown=true
