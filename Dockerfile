FROM java:7
COPY . /workspace
WORKDIR /workspace
VOLUME /output

ENV MESOS_HDFS_TAG 0.1.4

RUN git clone https://github.com/mesosphere/hdfs.git && \
    cd hdfs && \
    git checkout -b $MESOS_HDFS_TAG tags/$MESOS_HDFS_TAG

ADD ./conf/* ./hdfs/conf/

CMD ["./build.sh"]
