#!/bin/bash
if [ -d ${DATA_DIR}/war ]; then
	CUR_V="$(find ${DATA_DIR}/war -name installedv* | cut -d 'v' -f2)"
fi
LAT_V="$(curl -s https://api.github.com/repos/jenkinsci/jenkins/releases/latest | grep tag_name | cut -d '-' -f2 | cut -d '"' -f1)"
if [ "${JENKINS_V}" == "latest" ]; then
	JENKINS_V=$LAT_V
    DL_V="latest"
else
	DL_V="${JENKINS_V}"
fi

echo "---Checking for 'runtime' folder---"
if [ ! -d ${DATA_DIR}/runtime ]; then
	echo "---'runtime' folder not found, creating...---"
	mkdir ${DATA_DIR}/runtime
else
	echo "---"runtime" folder found---"
fi

if [ ! -z "$(find ${DATA_DIR}/runtime -name jre*)" ]; then
	if [ "${RUNTIME_NAME}" == "basicjre" ]; then
		if [ "$(ls -d ${DATA_DIR}/runtime/* | cut -d '/' -f5)" != "jre1.8.0_333" ]; then
			rm -rf ${DATA_DIR}/runtime/*
		fi
	elif [ "${RUNTIME_NAME}" != "$(ls -d ${DATA_DIR}/runtime/* | cut -d '/' -f4)" ]; then
		rm -rf ${DATA_DIR}/runtime/*
	fi
fi

echo "---Checking if Runtime is installed---"
if [ -z "$(find ${DATA_DIR}/runtime -name jre*)" ]; then
    if [ "${RUNTIME_NAME}" == "basicjre" ]; then
    	echo "---Downloading and installing Basic Runtime---"
		cd ${DATA_DIR}/runtime
		if wget -q -nc --show-progress --progress=bar:force:noscroll https://github.com/ich777/runtimes/raw/master/jre/basicjre.tar.gz ; then
			echo "---Successfully downloaded Runtime!---"
		else
			echo "---Something went wrong, can't download Runtime, putting server in sleep mode---"
			sleep infinity
		fi
        tar --directory ${DATA_DIR}/runtime -xvzf ${DATA_DIR}/runtime/basicjre.tar.gz
        rm -rf ${DATA_DIR}/runtime/basicjre.tar.gz
	elif  [ "${RUNTIME_NAME}" == "jre11" ]; then
		JRE11_URL="https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9.1%2B1/OpenJDK11U-jre_x64_linux_hotspot_11.0.9.1_1.tar.gz"
    	echo "---Downloading and installing JRE11---"
		cd ${DATA_DIR}/runtime
		if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz ${JRE11_URL} ; then
			echo "---Successfully downloaded JRE11!---"
		else
			echo "---Something went wrong, can't download JRE11, putting server in sleep mode---"
			sleep infinity
		fi
		mkdir ${DATA_DIR}/runtime/${RUNTIME_NAME}
        tar --directory ${DATA_DIR}/runtime/${RUNTIME_NAME} --strip-components=1 -xvzf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
        rm -rf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
	elif  [ "${RUNTIME_NAME}" == "jre15" ]; then
		JRE15_URL="https://github.com/AdoptOpenJDK/openjdk15-binaries/releases/download/jdk-15.0.1%2B9/OpenJDK15U-jre_x64_linux_hotspot_15.0.1_9.tar.gz"
    	echo "---Downloading and installing JRE15---"
		cd ${DATA_DIR}/runtime
		if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz ${JRE15_URL} ; then
			echo "---Successfully downloaded JRE15!---"
		else
			echo "---Something went wrong, can't download JRE15, putting server in sleep mode---"
			sleep infinity
		fi
		mkdir ${DATA_DIR}/runtime/${RUNTIME_NAME}
        tar --directory ${DATA_DIR}/runtime/${RUNTIME_NAME} --strip-components=1 -xvzf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
        rm -rf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
	elif  [ "${RUNTIME_NAME}" == "jre16" ]; then
		JRE16_URL="https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk16u-2021-05-08-12-45/OpenJDK16U-jre_x64_linux_hotspot_2021-05-08-12-45.tar.gz"
    	echo "---Downloading and installing JRE16---"
		cd ${DATA_DIR}/runtime
		if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz ${JRE16_URL} ; then
			echo "---Successfully downloaded JRE16!---"
		else
			echo "---Something went wrong, can't download JRE16, putting server in sleep mode---"
			sleep infinity
		fi
		mkdir ${DATA_DIR}/runtime/${RUNTIME_NAME}
        tar --directory ${DATA_DIR}/runtime/${RUNTIME_NAME} --strip-components=1 -xvzf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
        rm -rf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
	elif  [ "${RUNTIME_NAME}" == "jre17" ]; then
		JRE17_URL="https://github.com/AdoptOpenJDK/openjdk17-binaries/releases/download/jdk-2021-05-07-13-31/OpenJDK-jdk_x64_linux_hotspot_2021-05-06-23-30.tar.gz"
    	echo "---Downloading and installing JRE17---"
		cd ${DATA_DIR}/runtime
		if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz ${JRE17_URL} ; then
			echo "---Successfully downloaded JRE17!---"
		else
			echo "---Something went wrong, can't download JRE17, putting server in sleep mode---"
			sleep infinity
		fi
		mkdir ${DATA_DIR}/runtime/${RUNTIME_NAME}
        tar --directory ${DATA_DIR}/runtime/${RUNTIME_NAME} --strip-components=1 -xvzf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
        rm -rf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
	elif  [ "${RUNTIME_NAME}" == "jre21" ]; then
		JRE21_URL="https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz"
    	echo "---Downloading and installing JRE21---"
		cd ${DATA_DIR}/runtime
		if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz ${JRE21_URL} ; then
			echo "---Successfully downloaded JRE21!---"
		else
			echo "---Something went wrong, can't download JRE21, putting server in sleep mode---"
			sleep infinity
		fi
		mkdir ${DATA_DIR}/runtime/${RUNTIME_NAME}
        tar --directory ${DATA_DIR}/runtime/${RUNTIME_NAME} --strip-components=1 -xvzf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
        rm -rf ${DATA_DIR}/runtime/${RUNTIME_NAME}.tar.gz
    else
    	if [ ! -d ${DATA_DIR}/runtime/${RUNTIME_NAME} ]; then
        	echo "---------------------------------------------------------------------------------------------"
        	echo "---Runtime not found in folder 'runtime' please check again! Putting server in sleep mode!---"
        	echo "---------------------------------------------------------------------------------------------"
        	sleep infinity
        fi
    fi
else
	echo "---Runtime found---"
fi


echo "---Checking if Jenkins is installed---"
if [ ! -d ${DATA_DIR}/war ]; then
	mkdir ${DATA_DIR}/war
fi
if [ ! -f ${DATA_DIR}/war/jenkins.war ]; then
	echo "---Jenkins not found, downloading...---"
    cd ${DATA_DIR}/war
	if wget -q -nc --show-progress --progress=bar:force:noscroll "${JENKINS_URL}/jenkins/war/${DL_V}/jenkins.war" ; then
		echo "---Successfully downloaded Jenkins!---"
	else
		echo "---Something went wrong, can't download Jenkins, putting server in sleep mode---"
	sleep infinity
	fi
    touch ${DATA_DIR}/war/installedv${JENKINS_V}
    sleep 2
    CUR_V="$(find ${DATA_DIR}/war -name installedv* | cut -d 'v' -f2)"
fi

#echo "---Version Check---"
#if [ "${JENKINS_V}" != "$CUR_V" ]; then
#	echo "---Version missmatch v$CUR_V installed, installing v${JENKINS_V}---"
#    rm ${DATA_DIR}/war/installedv$CUR_V
#    rm ${DATA_DIR}/war/jenkins.war
#	cd ${DATA_DIR}/war
#	if wget -q -nc --show-progress --progress=bar:force:noscroll "${JENKINS_URL}/jenkins/war/${DL_V}/jenkins.war" ; then
#		echo "---Successfully downloaded Jenkins!---"
#	else
#		echo "---Something went wrong, can't download Jenkins, putting server in sleep mode---"
#	sleep infinity
#	fi
#    touch ${DATA_DIR}/war/installedv${JENKINS_V}
#elif [ "${JENKINS_V}" == "$CUR_V" ]; then
#	echo "---Server versions match! Installed: v$CUR_V | Preferred: v${JENKINS_V}---"
#fi

echo "---Preparing server---"
if [ ! -d ${DATA_DIR}/workdir ]; then
	mkdir ${DATA_DIR}/workdir
fi
export RUNTIME_NAME="$(ls -d ${DATA_DIR}/runtime/* | cut -d '/' -f4)"
export JENKINS_HOME=${DATA_DIR}/workdir
rm ${DATA_DIR}/.wget* > /dev/null 2>&1
chmod -R ${DATA_PERM} ${DATA_DIR}

if [ "${WEBSOCAT}" == "true" ]; then
  echo "---Starting Websocat Notify service...---"
  screen -S websocat -d -m /opt/scripts/start-websocat.sh
fi

cd ${DATA_DIR}/war
${DATA_DIR}/runtime/${RUNTIME_NAME}/bin/java -jar ${EXTRA_JVM_PARAMS} ${DATA_DIR}/war/jenkins.war --httpPort=${HTTP_PORT} ${EXTRA_JENKINS_PARAMS}