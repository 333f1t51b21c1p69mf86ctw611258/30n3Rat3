#!/bin/bash
#cd /home/devno4/eonerate/rerate
#java -Xms256m -Xmx512m -classpath ./eOneRate.jar:lib/nanoxml-lite-2.2.3.jar:lib/log4j-1.2.13.jar:lib/commons-lang-2.4.jar:lib/jakarta-oro-2.0.8.jar:lib/ojdbc6.jar ElcRate.ElcRate -p eOneRate.properties.xml &

export OR_ROOT_DIR=/home/oracle/tmp/abc/def/rerate
cd $OR_ROOT_DIR
export LIB_DIR=$OR_ROOT_DIR/lib
export OR_LIB_DIR=$OR_ROOT_DIR
export OR_LIB_VERSION=eOneRate.jar
export PROPERTIES_DIR=$OR_ROOT_DIR/properties
export CLASSPATH=$OR_LIB_DIR/eOneRate-v2.1.jar:$LIB_DIR/*.jar:$PROPERTIES_DIR:$CLASSPATH
cd $OR_ROOT_DIR

# "C:\Program Files\Java\jdk1.6.0_43\bin\java" -Xms64m -Xmx128m ElcRate.ElcRate -p PromoTelecom.properties.xml
/home/oracle/java/jdk1.8.0_05/bin/java ElcRate.ElcRate -p eOneRate.properties.xml &
