#!/usr/bin/env bash

# This file is sourced when running various Spark programs.
# Copy it as spark-env.sh and edit that to configure Spark for your site.

# Options read when launching programs locally with 
# ./bin/run-example or ./bin/spark-submit
# - HADOOP_CONF_DIR, to point Spark towards Hadoop configuration files
# - SPARK_LOCAL_IP, to set the IP address Spark binds to on this node
# - SPARK_PUBLIC_DNS, to set the public dns name of the driver program
# - SPARK_CLASSPATH, default classpath entries to append

# Options read by executors and drivers running inside the cluster
# - SPARK_LOCAL_IP, to set the IP address Spark binds to on this node
# - SPARK_PUBLIC_DNS, to set the public DNS name of the driver program
# - SPARK_CLASSPATH, default classpath entries to append
# - SPARK_LOCAL_DIRS, storage directories to use on this node for shuffle and RDD data
# - MESOS_NATIVE_LIBRARY, to point to your libmesos.so if you use Mesos

# Options read in YARN client mode
# - HADOOP_CONF_DIR, to point Spark towards Hadoop configuration files
# - SPARK_EXECUTOR_INSTANCES, Number of workers to start (Default: 2)
# - SPARK_EXECUTOR_CORES, Number of cores for the workers (Default: 1).
# - SPARK_EXECUTOR_MEMORY, Memory per Worker (e.g. 1000M, 2G) (Default: 1G)
# - SPARK_DRIVER_MEMORY, Memory for Master (e.g. 1000M, 2G) (Default: 512 Mb)
# - SPARK_YARN_APP_NAME, The name of your application (Default: Spark)
# - SPARK_YARN_QUEUE, The hadoop queue to use for allocation requests (Default: ‘default’)
# - SPARK_YARN_DIST_FILES, Comma separated list of files to be distributed with the job.
# - SPARK_YARN_DIST_ARCHIVES, Comma separated list of archives to be distributed with the job.

# Options for the daemons used in the standalone deploy mode:
# - SPARK_MASTER_IP, to bind the master to a different IP address or hostname
# - SPARK_MASTER_PORT / SPARK_MASTER_WEBUI_PORT, to use non-default ports for the master
# - SPARK_MASTER_OPTS, to set config properties only for the master (e.g. "-Dx=y")
# - SPARK_WORKER_CORES, to set the number of cores to use on this machine
# - SPARK_WORKER_MEMORY, to set how much total memory workers have to give executors (e.g. 1000m, 2g)
# - SPARK_WORKER_PORT / SPARK_WORKER_WEBUI_PORT, to use non-default ports for the worker
# - SPARK_WORKER_INSTANCES, to set the number of worker processes per node
# - SPARK_WORKER_DIR, to set the working directory of worker processes
# - SPARK_WORKER_OPTS, to set config properties only for the worker (e.g. "-Dx=y")
# - SPARK_HISTORY_OPTS, to set config properties only for the history server (e.g. "-Dx=y")
# - SPARK_DAEMON_JAVA_OPTS, to set config properties for all daemons (e.g. "-Dx=y")
# - SPARK_PUBLIC_DNS, to set the public dns name of the master or workers

###
### === IMPORTANT ===
### Change the following to specify a real cluster's Master host
###
export STANDALONE_SPARK_MASTER_HOST=`hostname`

export SPARK_MASTER_IP=$STANDALONE_SPARK_MASTER_HOST

### Let's run everything with JVM runtime, instead of Scala
export SPARK_LAUNCH_WITH_SCALA=0
export SPARK_LIBRARY_PATH=${SPARK_HOME}/lib
export SCALA_LIBRARY_PATH=${SPARK_HOME}/lib
export SPARK_MASTER_WEBUI_PORT=18080
export SPARK_MASTER_PORT=7077
export SPARK_WORKER_PORT=7078
export SPARK_WORKER_WEBUI_PORT=18081
export SPARK_WORKER_DIR=/var/run/spark/work
export SPARK_LOG_DIR={{ spark_log_dir }}
export SPARK_HISTORY_SERVER_LOG_DIR='{{ spark_event_log }}'
export SPARK_PID_DIR='/var/run/spark/'
export HADOOP_HOME=/usr/lib/hadoop

if [ -n "$HADOOP_HOME" ]; then
  export SPARK_LIBRARY_PATH=$SPARK_LIBRARY_PATH:${HADOOP_HOME}/lib/native
fi

export SPARK_HISTORY_OPTS="$SPARK_HISTORY_OPTS -Dspark.history.kerberos.enabled=true -Dspark.history.kerberos.principal=spark/{{ ansible_nodename }} -Dspark.history.kerberos.keytab=/etc/spark/conf/spark.keytab -Djava.library.path=$SPARK_LIBRARY_PATH"

export HADOOP_CONF_DIR=/etc/hadoop/conf
HIVE_CONF_DIR=/etc/hive/conf:/usr/lib/hive/lib/*
HBASE_CONF_DIR=/etc/hbase/conf:/usr/lib/hbase/lib/*
SPARK_DIST_CLASSPATH=$(hadoop --config /etc/hadoop/conf classpath)
export SPARK_DIST_CLASSPATH=${SPARK_DIST_CLASSPATH}:$HIVE_CONF_DIR:$HBASE_CONF_DIR
export HADOOP_CONF_DIR=/etc/hadoop/conf
export SPARK_EXECUTOR_INSTANCES=4
export SPARK_EXECUTOR_CORES=1
export SPARK_EXECUTOR_MEMORY=1024m
export SPARK_DRIVER_MEMORY=512m
export SPARK_YARN_QUEUE="default"
export SPARK_SUBMIT_LIBRARY_PATH=$SPARK_LIBRARY_PATH
#export SPARK_YARN_DIST_FILES=""
#export SPARK_YARN_DIST_ARCHIVES=""

#export SPARK_JAR=hdfs://21cnCDHTest/user/spark/spark-assembly.jar

### Comment above 2 lines and uncomment the following if
### you want to run with scala version, that is included with the package
#export SCALA_HOME=${SCALA_HOME:-/usr/lib/spark/scala}
#export PATH=$PATH:$SCALA_HOME/bin

