#!/bin/bash

export JAR_FILE_NAME=hotexport-1.0.jar

export OR_ROOT_DIR=/home/eonerate/deploy/hotexport
cd $OR_ROOT_DIR

export LIB_DIR=$OR_ROOT_DIR/lib
export PROPERTIES_DIR=$OR_ROOT_DIR/config
export CLASSPATH=$PROPERTIES_DIR:$OR_ROOT_DIR/$JAR_FILE_NAME:$LIB_DIR/activation-1.1.jar:$LIB_DIR/commons-lang-2.6.jar:$LIB_DIR/commons-collections-3.2.1.jar:$LIB_DIR/c3p0-0.9.1.2.jar:$LIB_DIR/bonecp-0.8.0.RELEASE.jar:$LIB_DIR/aopalliance-1.0.jar:$LIB_DIR/activemq-protobuf-1.1.jar:$LIB_DIR/activemq-core-5.7.0.jar:$LIB_DIR/jasypt-1.9.0.jar:$LIB_DIR/hawtdispatch-transport-1.11.jar:$LIB_DIR/hawtdispatch-1.11.jar:$LIB_DIR/hawtbuf-1.9.jar:$LIB_DIR/guava-13.0.1.jar:$LIB_DIR/geronimo-jms_1.1_spec-1.1.1.jar:$LIB_DIR/geronimo-j2ee-management_1.1_spec-1.0.1.jar:$LIB_DIR/commons-pool-1.5.5.jar:$LIB_DIR/commons-net-3.1.jar:$LIB_DIR/commons-logging-1.1.1.jar:$LIB_DIR/mqtt-client-1.3.jar:$LIB_DIR/mail-1.4.jar:$LIB_DIR/log4j-1.2.17.jar:$LIB_DIR/kahadb-5.7.0.jar:$LIB_DIR/hsqldb-2.2.4.jar:$LIB_DIR/spring-asm-3.0.5.RELEASE.jar:$LIB_DIR/spring-aop-3.0.5.RELEASE.jar:$LIB_DIR/slf4j-log4j12-1.7.2.jar:$LIB_DIR/slf4j-api-1.7.2.jar:$LIB_DIR/oro-2.0.8.jar:$LIB_DIR/ojdbc6.jar:$LIB_DIR/mysql-connector-java-5.1.13.jar:$LIB_DIR/spring-expression-3.0.5.RELEASE.jar:$LIB_DIR/spring-core-3.0.5.RELEASE.jar:$LIB_DIR/spring-context-support-3.0.5.RELEASE.jar:$LIB_DIR/spring-context-3.0.5.RELEASE.jar:$LIB_DIR/spring-beans-3.0.5.RELEASE.jar:$CLASSPATH

java ElcRate.ElcRate -p hotexport.properties.xml &
