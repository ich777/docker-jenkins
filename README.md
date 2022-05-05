# Jenkins in Docker optimized for Unraid
This container will download and install the preferred version of Jenkins and install it.

**Update Notice:** If set to 'latest' the container will check on every startup if there is a newer version available).

All you data is stored in the jenkins/workdir folder in your appdata directory.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| JENKINS_V | Enter the version wich you want to download or set to 'latest' (without quotes) to download the latest version and check on every restart if there is a newer version. | latest |
| JENKINS_URL | Mirror from wich to download jenkins you can get them from here: http://mirrors.jenkins-ci.org/status.html (Exemple for mirrors are: ftp://mirror.serverion.com | http://mirror.xmission.com | http://mirror.serverion.com | http://ftp-chi.osuosl.org/pub | ...). | ftp://mirror.serverion.com |
| EXTRA_JENKINS_PARAMS | Enter extra Jenkins startup parameters if needed. | empty |
| EXTRA_JVM_PARAMS | Enter extra JVM start parameters if needed. | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |

## Run example
```
docker run --name Jenkins -d \
	-p 8080:8080 \
	--env 'JENKINS_V=latest' \
	--env 'JENKINS_URL=ftp://mirror.serverion.com' \
	--env 'RUNTIME_NAME=jre11' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/jenkins:/jenkins \
	ich777/jenkins
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

#### Support Thread: https://forums.unraid.net/topic/83786-support-ich777-application-dockers/