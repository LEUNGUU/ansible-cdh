#hadoop options
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"{{ hadoop_config_dir }}"}
export IP_OPTS="-Djava.net.preferIPv4Stack=true"
export GC_OPTS="-XX:+UseConcMarkSweepGC -XX:SurvivorRatio=5 -XX:MaxTenuringThreshold=20 -XX:CMSInitiatingOccupancyFraction=80 -XX:+ExplicitGCInvokesConcurrent"
export LD_LIBRARY_PATH=/usr/lib64:/usr/lib/hadoop/lib/native

#yarn options
export YARN_LOG_DIR="{{ yarn_log_dir }}"
export HADOOP_YARN_HOME="/usr/lib/hadoop-yarn"
export YARN_RESOURCEMANAGER_OPTS="-Xms2048m -Xmx2048m -Xmn768m"
export YARN_NODEMANAGER_OPTS="-Xms1024m -Xmx1024m -Xmn256m"
export YARN_OPTS="$IP_OPTS $GC_OPTS $YARN_OPTS"

if [ "x$JAVA_LIBRARY_PATH" != "x" ]; then
  YARN_OPTS="$YARN_OPTS -Djava.library.path=$JAVA_LIBRARY_PATH"
fi
