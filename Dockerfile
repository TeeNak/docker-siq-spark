#
# sudo docker build -t teenak/siq-spark:1.6.0 .

FROM sequenceiq/hadoop-docker:2.6.0
MAINTAINER TeeNak <teenak77@gmail.com>

#support for Hadoop 2.6.0
RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.6.0-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin


ADD core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
ADD yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml

# remove temp directory because node id is duplicated in clusuter environment
RUN rm -rf /tmp/hadoop-root/dfs/data
RUN rm -rf /tmp/hadoop-root/nm-local-dir

# update boot script
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh


ENTRYPOINT ["/etc/bootstrap.sh"]
