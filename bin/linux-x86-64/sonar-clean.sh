#!/bin/bash
sonar.sh stop

rm -rf $SONAR_HOME/logs
mkdir $SONAR_HOME/logs
rm -rf $SONAR_HOME/temp
mkdir $SONAR_HOME/temp
rm -rf $SONAR_HOME/data
mkdir $SONAR_HOME/data

