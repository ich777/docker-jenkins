FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends curl && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/jenkins"
ENV RUNTIME_NAME="basicjre"
ENV JENKINS_V="latest"
ENV JENKINS_URL="ftp://mirror.serverion.com/"
ENV HTTP_PORT=8080
ENV EXTRA_JENKINS_PARAMS=""
ENV EXTRA_JVM_PARAMS=""
ENV UMASK=000
ENV UID=99
ENV GID=100

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID jenkins && \
	chown -R jenkins $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/ && \
	chown -R jenkins /opt/scripts

USER jenkins

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]