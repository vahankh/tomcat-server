# tomcat-server

docker run --name proj-server -p 8080:8080 -dit -w /opt/webapps -v ~/java/auth/target/proj.war:/opt/webapps/proj.war vahankh/tomcat-server
