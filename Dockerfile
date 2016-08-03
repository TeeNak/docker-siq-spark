#
# sudo docker build -t teenak/siq-spark:1.6.0 .

FROM sequenceiq/spark:1.6.0
MAINTAINER Taishun Nakatani <teenak77@gmail.com>

ADD core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
ADD yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml

# update boot script
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh
