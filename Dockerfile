FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends curl git && \
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
ENV DATA_PERM=770
ENV USER="jenkins"

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]