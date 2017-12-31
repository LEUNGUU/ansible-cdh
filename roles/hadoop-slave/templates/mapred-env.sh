#hadoop options
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"{{ hadoop_config_dir }}"}
export HADOOP_CLIENT_OPTS="-Xms512m -Xmx512m $HADOOP_CLIENT_OPTS"
export HADOOP_COMMON_HOME="/usr/lib/hadoop"
export HADOOP_HDFS_HOME="/usr/lib/hadoop-hdfs"
export HADOOP_YARN_HOME="/usr/lib/hadoop-yarn"
export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
export JAVA_LIBRARY_PATH="$HADOOP_COMMON_HOME/lib/native"

#mapred options
export HADOOP_MAPRED_HOME=$( ([[ ! '/usr/lib/hadoop-mapreduce' =~ CDH_MR2_HOME ]] && echo /usr/lib/hadoop-mapreduce ) || echo ${CDH_MR2_HOME:-/usr/lib/hadoop-mapreduce/}  )
export HADOOP_MAPRED_LOG_DIR="{{ mapred_log_dir }}"
export YARN_LOG_DIR=""
export HADOOP_JOB_HISTORYSERVER_HEAPSIZE=1000
export HADOOP_MAPRED_ROOT_LOGGER=INFO,RFA
