# ansible-cdh


* NOTICE: As an example, this project installs CDH cluster in five worker nodes and a client node. You can customize your own cluster by setting variables in scripts or adding new roles to install new components. Feel free to play with it and welcome suggestions and criticisms.

## How to use it

* get codes from git

* prepare your worker nodes and client node(Centos 6.x or rhel 6.x required)

* set FQDN in your worker nodes and client node or use dns resolutions.

* put your FQDN in inventory file(production)

* build the kerberos cluster and generate user keytabs(hdfs, yarn, zookeeper...etc)

* deploy the cluster
``` bash
ansible-playbook -i production control.yml
```
* or deploy one of the components(hadoop and hbase contains two roles, master and slave)
```bash
ansible-playbook -i production control.yml --tags=hive
```

## Finally, Can I repost it?

Feel free to play with codes, fork it or send pull request, but, nope, you can not repost it, just direct them to here. Also, the use of the script is at your on risk and your own responsibility, and has nothing to do with me.
