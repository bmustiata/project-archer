
#
# Deploy the artifact.
#
function deploy() {
	pushd $CIPLOGIC_PROJECT_FOLDER
	for ARTIFACT in $CIPLOGIC_PROJECT_ARTIFACTS; do
		if [[ "$CIPLOGIC_PROJECT_SERVER_ARTIFACT" == "" ]]; then
			cp $ARTIFACT $CIPLOGIC_SERVER_HOME_FOLDER/$CIPLOGIC_SERVER_WORK_FOLDER
		else
			cp $ARTIFACT $CIPLOGIC_SERVER_HOME_FOLDER/$CIPLOGIC_SERVER_WORK_FOLDER/$CIPLOGIC_PROJECT_SERVER_ARTIFACT
		fi
	done
	popd
}

#
# Undeploy the current project.
#
function undeploy() {
	pushd $CIPLOGIC_SERVER_HOME_FOLDER/$CIPLOGIC_SERVER_WORK_FOLDER
	for ARTIFACT in $CIPLOGIC_PROJECT_DEPLOYED_ARTIFACTS; do
		rm -fr $ARTIFACT
	done
	popd
}

#
# Display the current settings on the screen.
#
function settings()
{
    if [[ "-v" = "$1" ]]; then
        echo -e "${FWHT}Project: $HC$FGRN$CIPLOGIC_PROJECT$RS $FBLK($HC$CIPLOGIC_PROJECT_FOLDER$RS$FBLK)$RS"
        echo -e "${FWHT}Server : $HC$FGRN$CIPLOGIC_SERVER$RS $FBLK($HC$CIPLOGIC_SERVER_HOME_FOLDER$RS$FBLK)$RS"
        echo -e "${FWHT}Java   : $HC${FGRN}v$CIPLOGIC_JAVA$RS $FBLK($HC$CIPLOGIC_JAVA_HOME$RS$FBLK)$RS"
    else
        echo -e "${FWHT}Project: $HC$FGRN$CIPLOGIC_PROJECT$RS"
        echo -e "${FWHT}Server : $HC$FGRN$CIPLOGIC_SERVER$RS"
        echo -e "${FWHT}Java   : $HC${FGRN}v$CIPLOGIC_JAVA$RS"
    fi
}

function redeploy() {
	undeploy
	deploy
}

function build() {
	pushd $CIPLOGIC_PROJECT_FOLDER
	mvn install $@
	popd
}

function clean() {
	pushd $CIPLOGIC_PROJECT_FOLDER
	mvn clean $@
	popd
}

#
# Clean the logs from the log folder.
#
function cleanlogs() {
	pushd $CIPLOGIC_SERVER_HOME_FOLDER/$CIPLOGIC_SERVER_LOG_FOLDER
    rm -f *
    popd
}

#
# Potato, potato... The same thing.
#
function clearlogs() {
    cleanlogs
}

function rebuild() {
	pushd $CIPLOGIC_PROJECT_FOLDER
	mvn clean install $@
	popd
}

function serverstart() {
	pushd $CIPLOGIC_SERVER_HOME_FOLDER
	bin/xstartup.sh
	popd
}


function serverstop() {
	kill -9 `ps x | tr -s " " " " | grep /java | cut -f1 -d\ `
}

#
# Displays the server status, if running or stopped.
#
function serverstatus() {
    RUNNING=`ps x | grep tomcat | grep java`

    echo -n -e "Server $HC$FBLE$CIPLOGIC_SERVER$RS status: "

    if [[ "" == "$RUNNING" ]]; then
        echo -e "$HC${FRED}stopped$RS"
    else # not [[ "" -eq "$RUNNING" ]]
        echo -e "$HC${FGRN}running$RS"
    fi   # else [[ "" -eq "$RUNNING" ]]
}

# cd bin of the server
function cdb() {
	cd $CIPLOGIC_SERVER_HOME_FOLDER/bin
}

# cd lgos of the server
function cdl() {
	cd $CIPLOGIC_SERVER_HOME_FOLDER/$CIPLOGIC_SERVER_LOG_FOLDER
}

# cd webapps of the server
function cdw() {
	cd $CIPLOGIC_SERVER_HOME_FOLDER/$CIPLOGIC_SERVER_WORK_FOLDER
}

# cd root of the server
function cds() {
	cd $CIPLOGIC_SERVER_HOME_FOLDER
}

# cd project
function cdproj() {
	cd $CIPLOGIC_PROJECT_FOLDER
}

function serverstop() {
	kill -9 `ps x | grep org.apache.catalina.startup.Bootstrap | grep -v grep | perl -e 'while(<>) { /\s*(\d+)/; print "$1\n" }'`
	#kill -9 `ps x| grep java| tr -s " " " " | cut -f1 -d\ `
}

function serverstart() {
	pushd .
	cds
	bin/xstartup.sh
	popd
}

alias gitserve="git daemon --reuseaddr --base-path=. --export-all --verbose --enable=receive-pack"

