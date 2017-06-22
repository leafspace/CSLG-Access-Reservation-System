#!/bin/sh  
  
# Define some constants  
ONSSERVER=ONSServer  
PROJECT_PATH=/home/pi/Desktop/ReservationVerify
JAR_PATH=$PROJECT_PATH/lib  
BIN_PATH=$PROJECT_PATH/bin  
  
# Run the project as a background process  
nohup java -classpath $BIN_PATH:$JAR_PATH/jdom.jar:$JAR_PATH/oro-2.0.8.jar com.ONSServer.DoUDPRequest &  
