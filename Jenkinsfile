def inputMap = input message: 'enter password', parameters: [password(defaultValue: 'value', description: '', name: 'VAULT_PASS')]

node("DOCKER_BUILD") {
    //currentBuild.result = "SUCCESS"

    stage('Checkout') { 
        // for display purposes
        // Get latest code from a GitHub repository
        checkout scm;
        def environment = 'dev'
        def vault_password = inputMap['VAULT_PASS']

    }

    stage("Deploy to ${environment}") {	
        sh "echo ./build_deploy_interactive.sh ${environment} ${vault_password}"
        //sh "./build_deploy_interactive.sh ${environment} ${vault_password}"

    }
}

    