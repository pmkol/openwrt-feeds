#!/bin/bash -e

rm -rf package/new/lite/{luci-app-passwall,xray-core}
mv ../master/archive-23.05/{luci-app-passwall,xray-core} package/new/lite/
echo "1750471200" > version.date
