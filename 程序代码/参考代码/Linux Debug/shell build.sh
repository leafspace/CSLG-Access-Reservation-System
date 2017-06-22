#!/bin/sh  
# Define some constants  
ONSSERVER=ONSServer
PROJECT_PATH=/home/pi/Desktop/ReservationVerify
JAR_PATH=$PROJECT_PATH/lib  
BIN_PATH=$PROJECT_PATH/bin  
SRC_PATH=$PROJECT_PATH/src/$ONSSERVER  
  
# First remove the sources.list file if it exists and then create the sources file of the project  
rm -f $SRC_PATH/sources  
find $SRC_PATH/com -name *.java > $SRC_PATH/sources.list  
  
# First remove the ONSServer directory if it exists and then create the bin directory of ONSServer  
rm -rf $BIN_PATH/$ONSSERVER  
mkdir $BIN_PATH/$ONSSERVER  
  
# Compile the project  
javac -d $BIN_PATH/$ONSSERVER -classpath $JAR_PATH/jdom.jar:$JAR_PATH/oro-2.0.8.jar @$SRC_PATH/sources.list
