ANDROID_GNSS_PATH_DEFAULT="/home/embuser/aosp-docker/_gnss_hal/"
ANDROID_GNSS_PATH=${ANDROID_GNSS_PATH:-$ANDROID_GNSS_PATH_DEFAULT}
AOSP_ARGS=""
if [ "$NO_TTY" = "" ]; then
AOSP_ARGS="${AOSP_ARGS} -t"
fi
if [ "$DOCKERHOSTNAME" != "" ]; then
AOSP_ARGS="${AOSP_ARGS} -h $DOCKERHOSTNAME"
fi
if [ "$HOST_USB" != "" ]; then
AOSP_ARGS="${AOSP_ARGS} -v /dev/bus/usb:/dev/bus/usb"
fi
if [ "$HOST_NET" != "" ]; then
AOSP_ARGS="${AOSP_ARGS} --net=host"
fi
if [ "$HOST_DISPLAY" != "" ]; then
AOSP_ARGS="${AOSP_ARGS} --env=DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix"
fi

#Make sure prerequisite directories exist in studio-data dir
mkdir -p studio-data/profile/AndroidStudio2022.3.1.20
mkdir -p studio-data/profile/android
mkdir -p studio-data/profile/gradle
mkdir -p studio-data/profile/java
mkdir -p studio-data/Android

VOLOK=`docker volume ls | grep -w android_studio`

if [ "$VOLOK" = "" ]; then
docker volume create android_studio
fi

# check xhost
XHOST=`xhost | grep LOCAL:`
if [ -z $XHOST ]; then
#xhost: non-network local connections being added to access control list
xhost local:android
fi

docker run --rm -i $AOSP_ARGS -v `pwd`/studio-data:/studio-data -v android_studio:/androidstudio-data -v `pwd`/workdir:/workdir --device=/dev/kvm --name android_studio --privileged --group-add kvm --group-add plugdev deadolus/android-studio $@
