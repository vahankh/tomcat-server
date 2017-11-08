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

# Securing tomcat
RUN \
  rm -R $CATALINA_HOME/webapps/* && \
  addgroup -gid 900 tomcat && \
  adduser --home $CATALINA_HOME -uid 900 -ingroup tomcat --shell /bin/bash --system --no-create-home --disabled-login --disabled-password tomcat && \
  chown -R tomcat.tomcat $CATALINA_HOME && \
  chmod -R 0550 $CATALINA_HOME && \
  chmod 0400 $CATALINA_HOME/conf/* && \
  chmod -R 0700 $CATALINA_HOME/logs

# Problem writing into temp folder. While couldn't find the issue re-creating it solves the problem
RUN \
  rm -R -f $CATALINA_HOME/temp && \
  mkdir $CATALINA_HOME/temp && \
  chown -R tomcat.tomcat $CATALINA_HOME/temp

# Preparing webapps directory
RUN \
  mkdir /opt/webapps && \
  chown -R tomcat:tomcat /opt/webapps && \
  chmod -R 750 /opt/webapps && \
  sed -i -- 's/appBase="webapps"/appBase="\/opt\/webapps"/g' $CATALINA_HOME/conf/server.xml

USER tomcat
