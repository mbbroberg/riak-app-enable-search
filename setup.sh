#!/bin/bash

echo "Starting.."

# Map to the directory where the Riak.app stores Riak
export RIAK_APP="/Applications/Riak.app/Contents/Resources/riak-2.1.0"

if [ ! -d "$RIAK_APP" ]
then
    echo "It doesn't look like you have the Riak.app installed. Please install it to proceed."
    exit 1
else
    echo "You have the app installed!"
fi

CONF=$RIAK_APP/etc/riak.conf

echo "Enabling Apache Solr in $CONF"

sed -i -e 's/search = off/search = on/g' $CONF

echo "Making sure we restart Riak."

$RIAK_APP/bin/riak stop
$RIAK_APP/bin/riak start
$RIAK_APP/bin/riak-admin ring-status
echo "If you see no errors in the status output, then you're ready to go!"

