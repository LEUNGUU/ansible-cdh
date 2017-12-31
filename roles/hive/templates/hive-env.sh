export HADOOP_HOME=/usr/lib/hadoop
export HADOOP_CLIENT_OPTS="-Djava.net.preferIPv4Stack=true -Dhive.log.dir={{ hive_log_dir }}/`whoami` -Dhive.log.threshold={{ log_level }} $HADOOP_CLIENT_OPTS"
export HIVE_CONFIG_DIR={{ hive_config_dir }}
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$SENTRY_HOME/lib
if [ `whoami` == "hive" ];then
export HADOOP_CLIENT_OPTS="${HADOOP_CLIENT_OPTS} -Djava.security.auth.login.config=/etc/hive/conf/zk-jaas.conf"
else
USER=`whoami`
HOST=`hostname`
cat <<EOF > ${HOME}/zk-jaas.conf
Client {
  com.sun.security.auth.module.Krb5LoginModule required
  useKeyTab=true
  keyTab="${HOME}/${USER}_${HOST}.keytab"
  useTicketCache=false
  principal="${USER}/${HOST}@{{ cluster_domain|upper() }}";
};
EOF
export HADOOP_CLIENT_OPTS="${HADOOP_CLIENT_OPTS} -Djava.security.auth.login.config=${HOME}/zk-jaas.conf"
fi

