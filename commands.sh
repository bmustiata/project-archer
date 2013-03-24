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

function undeploy() {
	pushd $CIPLOGIC_SERVER_HOME_FOLDER/$CIPLOGIC_SERVER_WORK_FOLDER
	for ARTIFACT in $CIPLOGIC_PROJECT_DEPLOYED_ARTIFACTS; do
		rm -fr $ARTIFACT
	done
	popd
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
	kill -9 `ps x | tr -s " " " " | grep /java | cut -f2 -d\ `
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
	kill -9 `ps | grep java| tr -s " " " " | cut -f2 -d\ `
}

function serverstart() {
	pushd .
	cdb
	./xstartup.sh
	popd
}

alias gitserve="git daemon --reuseaddr --base-path=. --export-all --verbose --enable=receive-pack"

