export ROOT_DIR=/oracle/node1/eonerate/cdrintegration
export LIB_DIR=$ROOT_DIR/lib
export DIST_DIR=$ROOT_DIR/dist
export PROPERTIES_DIR=$ROOT_DIR/properties
export  CLASSPATH=$PROPERTIES_DIR:$DIST_DIR/eonerate.cdrintegration-2.13.1.jar:$LIB_DIR/slf4j-log4j12-1.7.7.jar:$LIB_DIR/slf4j-api-1.6.6.jar:$LIB_DIR/log4j-1.2.17.jar:$LIB_DIR/jsch-0.1.50.jar:$LIB_DIR/jaxb-impl-2.2.6.jar:$LIB_DIR/commons-net-3.3.jar:$LIB_DIR/camel-zipfile-2.13.1.jar:$LIB_DIR/camel-ftp-2.13.1.jar:$LIB_DIR/camel-core-2.13.1.jar

cd $ROOT_DIR
/usr/java6/bin/java -Xms1024m -Xmx1024m eonerate.cdrintegration.IntServer &