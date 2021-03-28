#!/bin/bash
hdfs dfs -mkdir /spark_jars
hdfs dfs -put ${HOME}/spark/jars /spark_jars