FROM ich777/debian-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-jenkins"

RUN apt-get update && \
	apt-get -y install --no-install-recommends curl git libfontconfig apt-transport-https ca-certificates gnupg2 jq screen && \
	curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
	apt-get update && \
	apt-get -y install docker-ce && \
	apt-get -y remove apt-transport-https gnupg2 && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

RUN wget -qO /usr/local/bin/websocat https://github.com/vi/websocat/releases/latest/download/websocat.x86_64-unknown-linux-musl && \
	chmod a+x /usr/local/bin/websocat

ENV DATA_DIR="/jenkins"
ENV RUNTIME_NAME="jre17"
ENV JENKINS_V="latest"
ENV JENKINS_URL="ftp://mirror.serverion.com/"
ENV WEBSOCAT="false"
ENV HTTP_PORT=8080
ENV EXTRA_JENKINS_PARAMS=""
ENV EXTRA_JVM_PARAMS=""
ENV FORCE_BASICJRE_UPDATE=""
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

EXPOSE 8080

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]