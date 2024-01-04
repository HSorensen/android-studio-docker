#!/usr/bin/bash

docker build -t deadolus/android-studio .
RETVAL=$?
if [ "$RETVAL" -ne "0" ]; then
  echo "Error building image: $RETVAL"
  return $RETVAL
fi

HOST_NET=1 HOST_DISPLAY=1 ./run.sh
