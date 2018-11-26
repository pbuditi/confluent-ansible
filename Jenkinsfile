node("DOCKER_BUILD") {

input (
        id: 'rioInput', message: 'enter password', parameters: [
        password(defaultValue: 'value', description: '', name: 'vault')
    ])

currentBuild.result = "SUCCESS"
def environment = 'dev'
def vault_password = ''

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
        sh "echo ./build_deploy_interactive.sh ${environment} ${vault_password}"
        sh "./build_deploy_interactive.sh ${environment} ${vault_password}"

    }
}
    