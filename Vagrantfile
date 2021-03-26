$script =  <<-SCRIPT
yum -y install vim java-1.8.0-openjdk-devel wget tmux

if [ ! -f /vagrant/hadoop-3.2.2.tar.gz ]
then
    cd /vagrant
    wget https://downloads.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz
fi

if [ ! -d /home/vagrant/hadoop-3.2.2 ]
then
    cd /home/vagrant
    tar xvf /vagrant/hadoop-3.2.2.tar.gz 
    ln -s  hadoop-3.2.2 hadoop
fi


if [ ! -f /vagrant/apache-zookeeper-3.6.2-bin.tar.gz ]
    then
        cd /vagrant
        wget https://downloads.apache.org/zookeeper/zookeeper-3.6.2/apache-zookeeper-3.6.2-bin.tar.gz
fi
    

if [ ! -d /home/vagrant/apache-zookeeper-3.6.2-bin ]
then
    cd /home/vagrant
    tar xvf /vagrant/apache-zookeeper-3.6.2-bin.tar.gz
    ln -s apache-zookeeper-3.6.2-bin zoo
fi

chown -R vagrant:vagrant /home/vagrant/apache-zookeeper-3.6.2-bin   
mkdir -p /data/zookeeper
chown -R vagrant:vagrant /data
cp /vagrant/etc/zoo.cfg /home/vagrant/zoo/conf/


if [ ! -f /vagrant/spark-3.1.1-bin-hadoop3.2.tgz ] 
then
    cd /vagrant
    wget https://downloads.apache.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz
fi

if [ ! -d /home/vagrant/spark-3.1.1-bin-hadoop3.2 ]
then
    cd /home/vagrant
    tar xvf /vagrant/spark-3.1.1-bin-hadoop3.2.tgz
    ln -s spark-3.1.1-bin-hadoop3.2 spark
    chown -R vagrant:vagrant spark
fi

HADOOP_CONF=/home/vagrant/hadoop/etc/hadoop
cp /vagrant/etc/hadoop-env.sh $HADOOP_CONF
cp /vagrant/etc/core-site.xml $HADOOP_CONF

if [ $(hostname) == "nn1.example.com" ]
then
    cp /vagrant/etc/hdfs-site-nn.xml $HADOOP_CONF/hdfs-site.xml
    cp /vagrant/etc/workers $HADOOP_CONF
    echo 1 > /data/zookeeper/myid
else    
    cp /vagrant/etc/hdfs-site.xml $HADOOP_CONF
fi

if [ $(hostname) == "dn1.example.com" ]
then
    echo 2 > /data/zookeeper/myid
fi

if [ $(hostname) == "dn2.example.com" ] 
then
    echo 3 > /data/zookeeper/myid
fi

if [ $(hostname) == "dn3.example.com" ] 
    then
        echo 3 > /data/zookeeper/myid
fi
    

cp /vagrant/etc/mapred-site.xml $HADOOP_CONF
cp /vagrant/etc/yarn-site.xml $HADOOP_CONF
cp /vagrant/etc/spark-env.sh $SPARK_HOME/conf
cp /vagrant/etc/spark-defaults.conf $SPARK_HOME/conf
mkdir -p /data/namenode
mkdir -p /data/datanode
chown -R vagrant:vagrant /data
cat /vagrant/keys/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
cat /vagrant/keys/id_rsa > /home/vagrant/.ssh/id_rsa
chown -R vagrant:vagrant /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa
cp /vagrant/etc/hosts /etc/hosts
cp /vagrant/etc/.bashrc /home/vagrant
cp $SPARK_HOME/jars/spark-network-shuffle_2.12-3.1.1.jar $HADOOP_HOME/share/hadoop/yarn/lib/

SCRIPT


Vagrant.configure("2") do |config|

    config.vm.define "nn1" do |nn1|
        nn1.vm.box = "boxomatic/centos-8"
        nn1.vm.hostname = "nn1.example.com"
        nn1.vm.network "private_network", ip: "10.0.0.2", hostname: true
        nn1.vm.network "forwarded_port", guest: 8088, host: 8088
        nn1.vm.network "forwarded_port", guest: 9870, host: 9870
        nn1.vm.provider "virtualbox" do |v|
            v.memory = 2048 
        end
        nn1.vm.provision "shell", inline: $script
    end  

    config.vm.define "dn1" do |dn1|
        dn1.vm.box = "boxomatic/centos-8"
        dn1.vm.hostname = "dn1.example.com"
        dn1.vm.network "private_network", ip: "10.0.0.3", hostname: true
        dn1.vm.provider "virtualbox" do |v|
            v.memory = 2048 
        end
        dn1.vm.provision "shell", inline: $script
    end  

    config.vm.define "dn2" do |dn2|
        dn2.vm.box = "boxomatic/centos-8"
        dn2.vm.hostname = "dn2.example.com"
        dn2.vm.network "private_network", ip: "10.0.0.4", hostname: true
        dn2.vm.provider "virtualbox" do |v|
            v.memory = 2048 
        end
        dn2.vm.provision "shell", inline: $script
    end  

    config.vm.define "dn3" do |dn2|
        dn2.vm.box = "boxomatic/centos-8"
        dn2.vm.hostname = "dn3.example.com"
        dn2.vm.network "private_network", ip: "10.0.0.5", hostname: true
        dn2.vm.provider "virtualbox" do |v|
            v.memory = 2048 
        end
        dn2.vm.provision "shell", inline: $script
    end  
  end

