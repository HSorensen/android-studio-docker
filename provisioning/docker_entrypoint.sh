#!/bin/bash

#Change permissions of /dev/kvm for Android Emulator
#echo "`whoami`" | sudo -S chmod 777 /dev/kvm > /dev/null 2>&1

export PATH=$PATH:/studio-data/platform-tools/

# Ensure the Android directory exists and has the correct permissions
if [ ! -d "/studio-data/Android" ]; then
  mkdir -p /studio-data/Android
fi
sudo chown -R android:android /studio-data/Android

sudo chown -R android:android /studio-data/profile/android

touch /studio-data/profile/android/analytics.settings

sudo chown -R android:android /studio-data/profile/java

mkdir -p .java/.systemPrefs
sudo chown -R android:android .java/.systemPrefs

# Default to 'bash' if no arguments are provided
args="$@"
if [ -z "$args" ]; then
  args="~/android-studio/bin/studio.sh"
fi

exec $args
