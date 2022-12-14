# Hadoop image
FROM openjdk:11


RUN apt-get update \
  && apt-get -y install bash \
  && apt-get -y install jq \
  && apt-get -y install vim \
  && apt-get -y install net-tools

ENV USER root
ENV JAVA_HOME=/usr/local/openjdk-11

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

RUN groupadd --gid 7000 hadoop
RUN useradd -ms /bin/bash -g hadoop --uid 7000 hadoop
RUN mkdir -p /mnt/hadoop/dfs/name && mkdir -p /mnt/hadoop/dfs/data && mkdir -p /mnt/hadoop/journal/data

RUN curl -k https://dlcdn.apache.org/hadoop/common/hadoop-2.10.2/hadoop-2.10.2.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.10.2 hadoop

WORKDIR /usr/local/hadoop

RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/local/openjdk-11\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

RUN chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh


ADD core-site.xml.template /usr/local/hadoop/etc/hadoop/core-site.xml.template
ADD hdfs-site.xml.template /usr/local/hadoop/etc/hadoop/hdfs-site.xml.template

ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod a+x /etc/bootstrap.sh
ADD run.sh /etc/run.sh
RUN chmod +x /etc/run.sh

RUN chown hadoop:hadoop /etc/run.sh

ADD fence.sh /etc/fence.sh
RUN chown root:root /etc/fence.sh && chmod a+x /etc/fence.sh

RUN chown -R hadoop:hadoop /usr/local/hadoop
RUN chown -R hadoop:hadoop /mnt/hadoop/

CMD ["/etc/bootstrap.sh", "-d"]

# NameNode                Secondary NameNode  DataNode                     JournalNode  NFS Gateway    HttpFS         ZKFC
EXPOSE 9820 50070 50470   9820 50090 50495         50010 1004 50075 1006 50020  8485 8480    2049 4242 111  14000 14001    8019