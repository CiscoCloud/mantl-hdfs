#!/bin/bash

set -e

cd hdfs

sed -i 's,.*hdfs scheduler project needs.*,&\ncp $PROJ_DIR/conf/auth-config.sh $BUILD_DIR/$DIST/etc/hadoop,' ./bin/build-hdfs

./bin/build-hdfs
cp ./build/*.tgz /output/
