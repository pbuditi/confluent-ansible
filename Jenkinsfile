node("DOCKER_BUILD") {

properties([parameters([password(defaultValue: 'value', description: '', name: 'VAULT_PASS')])])

currentBuild.result = "SUCCESS"
def environment = 'dev'
def vault_password = "${VAULT_PASS}"

stage('Checkout') { // for display purposes
    // Get latest code from a GitHub repository
    checkout scm;
}

stage('Initalize'){
    //Get these from parameters later
    environment = 'dev'
    //vault_password = params.VAULT_PASS
}

stage("Deploy to ${environment}")
    {	
        sh "echo ./build_deploy_interactive.sh ${environment} ${VAULT_PASS}"
        sh "./build_deploy_interactive.sh ${environment} ${vault_password}"

    }
}
    