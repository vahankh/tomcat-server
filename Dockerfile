FROM tomcat:9

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# Install
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget curl bash-completion 

RUN \
  rm -R $CATALINA_HOME/webapps/* && \ 
  addgroup -gid 900 tomcat && \
  adduser --home $CATALINA_HOME -uid 900 -ingroup tomcat --shell /bin/bash --system --no-create-home --disabled-login --disabled-password tomcat && \
  chown -R tomcat:tomcat $CATALINA_HOME && \
  chmod 400 $CATALINA_HOME/conf/* && \
  chmod -R 300 $CATALINA_HOME/logs && \
  chmod -R 600 $CATALINA_HOME/temp && \
  chmod -R 550 $CATALINA_HOME && \
  chmod -R 550 $CATALINA_HOME/webapps

USER tomcat
#  rm -rf /var/lib/apt/lists/*
