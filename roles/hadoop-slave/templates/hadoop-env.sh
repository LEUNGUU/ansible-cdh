#hadoop options
export LD_LIBRARY_PATH=/usr/lib64
export HADOOP_HEAPSIZE=1000
export HADOOP_HDFS_HOME="/usr/lib/hadoop-hdfs"
export HADOOP_COMMON_HOME="/usr/lib/hadoop"
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"{{ hadoop_config_dir }}"}
export IP_OPTS="-Djava.net.preferIPv4Stack=true"
export GC_OPTS="-XX:+UseConcMarkSweepGC -XX:SurvivorRatio=5 -XX:MaxTenuringThreshold=20 -XX:CMSInitiatingOccupancyFraction=80 -XX:+ExplicitGCInvokesConcurrent"
export HADOOP_LOG_DIR="{{ hdfs_log_dir }}"
export HADOOP_OPTS="$IP_OPTS $GC_OPTS $HADOOP_OPTS"
export HADOOP_NAMENODE_OPTS="-Dcom.sun.management.jmxremote -Xms4096m -Xmx4096m -Xmn1536m"
export HADOOP_DATANODE_OPTS="-Dcom.sun.management.jmxremote -Xms1024m -Xmx1024m -Xmn256m"
export HADOOP_BALANCER_OPTS="-Dcom.sun.management.jmxremote -Xms1024m -Xmx1024m -Xmn256m"
export HADOOP_JOURNALNODE_OPTS="-Dcom.sun.management.jmxremote -Xms1024m -Xmx1024m -Xmn256m"
export HADOOP_ZKFC_OPTS="-Dcom.sun.management.jmxremote -Xms1024m -Xmx1024m -Xmn256m"
export HADOOP_CLIENT_OPTS="-Xms512m -Xmx512m $HADOOP_CLIENT_OPTS"
export SENTRY_HOME="/usr/lib/sentry"
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$SENTRY_HOME/lib/
export HADOOP_SECURE_DN_USER=hdfs
export HADOOP_SECURE_DN_PID_DIR=/var/run/hadoop-hdfs
export HADOOP_SECURE_DN_LOG_DIR=/data/logs/hadoop-hdfs
export JSVC_HOME=/usr/lib/bigtop-utils/
