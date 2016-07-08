#!/bin/sh

if [ -f "setup.sh" ]; then
   source $PWD/setup.sh
else
   export PATH=$PWD/soft/bin:$PATH
fi

export WMAROOT=/Users/knl/Projects/wmarchive/WMArchive
export WMA_STATIC_ROOT=$WMAROOT/data
export WMCOREROOT=/Users/knl/Projects/wmarchive/WMCore
export PYTHONPATH=$PYTHONPATH:$WMAROOT/src/python:$WMAROOT/etc:$WMCOREROOT/src/python
export PYTHONPATH=$PWD/python:$PYTHONPATH
log=$PWD/wmarch.log
if [ -f $log ]; then
   rm $log
fi
echo $PYTHONPATH

./stop_server.sh

cp -r $WMAROOT/src/css $WMAROOT/data/
cp -r $WMAROOT/src/images $WMAROOT/data/
cp -r $WMAROOT/src/js $WMAROOT/data/
cp -r $WMAROOT/src/maps $WMAROOT/data/
cp -r $WMAROOT/src/templates $WMAROOT/data/

$WMCOREROOT/bin/wmc-httpd -r -d /tmp -l $log $WMAROOT/etc/wmarch_config_local.py
