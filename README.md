# mantl-hdfs

[![Build Status](https://travis-ci.org/ryane/mantl-hdfs.svg?branch=master)](https://travis-ci.org/ryane/mantl-hdfs)

Builds a custom scheduler package for [HA HDFS on Apache Mesos](https://github.com/mesosphere/hdfs) that is compatible with [Mantl](http://mantl.io/). This is intended to be used with the [DCOS HDFS Package](https://docs.mesosphere.com/services/hdfs/).

The configuration files in the `conf` directory are modified from the default DCOS distribution to leverage [Consul](https://www.consul.io/) DNS.

## Usage

```shell
# Build the docker container
docker build -t mantl-hdfs .

# Build the package
docker run --rm -it -v $(pwd):/output mantl-hdfs
```

If everything works successfully, you should have a package called `hdfs-mesos-$version.tgz` in your current directory.

You can upload the package to a public location and add the url to the `hdfs.scheduler-uris` setting in an `options.json` file used when installing the HDFS package. See the [Installing HDFS on DCOS documentation](https://docs.mesosphere.com/services/hdfs/) for more information.

## Configuration Change Reference

### `hdfs-site.xml`


| Property Name                      | Property Value                                                                                                     |
|------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| dfs.namenode.rpc-address.hdfs.nn1  | namenode1.service.consul:50071                                                                                     |
| dfs.namenode.http-address.hdfs.nn1 | namenode1.service.consul:50070                                                                                     |
| dfs.namenode.rpc-address.hdfs.nn2  | namenode2.service.consul:50071                                                                                     |
| dfs.namenode.http-address.hdfs.nn2 | namenode2.service.consul:50070                                                                                     |
| dfs.namenode.shared.edits.dir      | qjournal://journalnode1.service.consul:8485;journalnode2.service.consul:8485;journalnode3.service.consul:8485/hdfs |
| ha.zookeeper.quorum                | zookeeper.service.consul:2181                                                                                      |


### `mesos-site.xml`


| Property Name                       | Property Value                           |
|-------------------------------------|------------------------------------------|
| mesos.hdfs.state.zk                 | zookeeper.service.consul:2181            |
| mesos.master.uri                    | zk://zookeeper.service.consul:2181/mesos |
| mesos.hdfs.zkfc.ha.zookeeper.quorum | zookeeper.service.consul:2181            |
| mesos.hdfs.mesosdns                 | false                                    |
| mesos.hdfs.native-hadoop-binaries   | false                                    |
| mesos.native.library                | /usr/local/lib/libmesos.so               |
| mesos.hdfs.ld-library-path          | /usr/local/lib                           |

