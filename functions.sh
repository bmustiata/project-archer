function add_project() {
	eval 'function project_'$1' {
		CIPLOGIC_PROJECT="'$1'"

		CIPLOGIC_PROJECT_FOLDER="'$2'"
		CIPLOGIC_PROJECT_ARTIFACTS="'$3'"
		CIPLOGIC_PROJECT_DEPLOYED_ARTIFACTS="'$4'"
		CIPLOGIC_PROJECT_SERVER_ARTIFACT="'$5'"

        byobu rename-window "$CIPLOGIC_PROJECT"

        ciplogic_update_ps1

        echo -e "${FWHT}Using project $HC$FGRN$CIPLOGIC_PROJECT$RS $FBLK($HC$CIPLOGIC_PROJECT_FOLDER$RS$FBLK)$RS"
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

        ciplogic_update_ps1

        echo -e "${FWHT}Using server $HC$FGRN$CIPLOGIC_SERVER$RS $FBLK($HC$CIPLOGIC_SERVER_HOME_FOLDER$RS$FBLK)$RS"
	}'
}

# adds a JVM for working.
# example: add_jvm 17 c:/programs/jdk1.7 /cygdrive/c/programs/jdk1.7/bin
function add_jvm() {
	eval 'function jvm_'$1' {
		CIPLOGIC_JAVA="'$1'"
        CIPLOGIC_JAVA_HOME="'$2'"

		export JAVA_HOME="'$2'"
		export PATH="'$3':$PATH"

        ciplogic_update_ps1

        echo -e "${FWHT}Using Java $HC${FGRN}v$CIPLOGIC_JAVA$RS $FBLK($HC$CIPLOGIC_JAVA_HOME$RS$FBLK)$RS"
	}'
}

function ciplogic_update_ps1() {
    PS1="${FBLK}$HC\\u${RS}($HC$FBLE$CIPLOGIC_PROJECT$RS>\$(ciplogic_server_status)):$FWHT\\w$HC\$$RS "
}

function ciplogic_server_status() {
    RUNNING=`ps x | grep tomcat | grep java`

    if [[ "" == "$RUNNING" ]]; then
        SERVER="$HC$FRED$CIPLOGIC_SERVER$RS"
    else # not [[ "" -eq "$RUNNING" ]]
        SERVER="$HC$FGRN$CIPLOGIC_SERVER$RS"
    fi   # else [[ "" -eq "$RUNNING" ]]

    echo -e $SERVER
}

function show_configuration() {
	echo "Working on project ${CIPLOGIC_PROJECT}, using ${CIPLOGIC_SERVER} on Java ${CIPLOGIC_JAVA}"
}
