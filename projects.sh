export PROJECT_VERSION="3.3.0.8-wfo-SNAPSHOT"

add_project coolproject "/project/location" "target/artifact.war" "deployed.war deployed" "deployed.war"

add_server tomcat7 "/cygdrive/d/programs/apache-tomcat-7.0.33" "webapps" "logs"

add_jvm 6 'C:\Program Files\Java\jdk1.6.0_26' '/cygdrive/c/Program Files/Java/jdk1.6.0_26/bin'
add_jvm 7 'C:\Program Files\Java\jdk1.7.0_11' '/cygdrive/c/Program Files/Java/jdk1.7.0_11/bin'
add_jvm 8 'C:\Program Files\Java\jdk1.8.0' '/cygdrive/c/Program Files/Java/jdk1.8.0/bin'


project_coolproject
server_tomcat7
jvm_6

