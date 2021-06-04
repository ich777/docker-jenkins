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

if [ "${FORCE_BASICJRE_UPDATE}" == "true" ]; then
	echo "---Forcing reinstall of Basic-Runtime---"
	if [ -d ${DATA_DIR}/runtime ]; then
    	echo "---Deleting existing Runtime---"
        rm -R ${DATA_DIR}/runtime
        mkdir ${DATA_DIR}/runtime
	fi
	echo "---Downloading and installing Basic-Runtime---"
	cd ${DATA_DIR}/runtime
	if wget -q -nc --show-progress --progress=bar:force:noscroll https://github.com/ich777/runtimes/raw/master/jre/basicjre.tar.gz ; then
		echo "---Successfully downloaded Basic-Runtime!---"
	else
		echo "---Something went wrong, can't download Basic-Runtime, putting server in sleep mode---"
		sleep infinity
	fi
	tar --directory ${DATA_DIR}/runtime -xvzf ${DATA_DIR}/runtime/basicjre.tar.gz
	rm -R ${DATA_DIR}/runtime/basicjre.tar.gz
else
	echo "---Checking if Runtime is installed---"
	if [ -z "$(find ${DATA_DIR}/runtime -name jre*)" ]; then
	    if [ "${RUNTIME_NAME}" == "basicjre" ]; then
	    	echo "---Downloading and installing Runtime---"
			cd ${DATA_DIR}/runtime
			if wget -q -nc --show-progress --progress=bar:force:noscroll https://github.com/ich777/runtimes/raw/master/jre/basicjre.tar.gz ; then
				echo "---Successfully downloaded Runtime!---"
			else
				echo "---Something went wrong, can't download Runtime, putting server in sleep mode---"
				sleep infinity
			fi
	        tar --directory ${DATA_DIR}/runtime -xvzf ${DATA_DIR}/runtime/basicjre.tar.gz
	        rm -R ${DATA_DIR}/runtime/basicjre.tar.gz
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

cd ${DATA_DIR}/war
${DATA_DIR}/runtime/${RUNTIME_NAME}/bin/java -jar ${EXTRA_JVM_PARAMS} ${DATA_DIR}/war/jenkins.war --httpPort=${HTTP_PORT} ${EXTRA_JENKINS_PARAMS}