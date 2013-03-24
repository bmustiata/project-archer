function add_project() {
	eval 'function project_'$1' {
		CIPLOGIC_PROJECT="'$1'"

		CIPLOGIC_PROJECT_FOLDER="'$2'"
		CIPLOGIC_PROJECT_ARTIFACTS="'$3'"
		CIPLOGIC_PROJECT_DEPLOYED_ARTIFACTS="'$4'"
		CIPLOGIC_PROJECT_SERVER_ARTIFACT="'$5'"

		echo "Using project $CIPLOGIC_PROJECT"
	}'
}

# adds a server into the servers definition
# example: add_server tomcat7 "/cygdrive/d/programs/apache-tomcat-7.0.33" webapps logs
function add_server() {
	eval 'function server_'$1' {
		CIPLOGIC_SERVER="'$1'"
		
		CIPLOGIC_SERVER_HOME_FOLDER="'$2'"
		CIPLOGIC_SERVER_WORK_FOLDER="'$3'"
		CIPLOGIC_SERVER_LOG_FOLDER="'$4'"
		
		echo "Using server $CIPLOGIC_SERVER"
	}'
}

# adds a JVM for working.
# example: add_jvm 17 c:/programs/jdk1.7 /cygdrive/c/programs/jdk1.7/bin
function add_jvm() {
	eval 'function jvm_'$1' {
		CIPLOGIC_JAVA="'$1'"
	
		export JAVA_HOME="'$2'"
		export PATH="'$3':$PATH"
		
		echo "Using java v$CIPLOGIC_JAVA"
	}'
}

function show_configuration() {
	echo "Working on project ${CIPLOGIC_PROJECT}, using ${CIPLOGIC_SERVER} on Java ${CIPLOGIC_JAVA}"
}
