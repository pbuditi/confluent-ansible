def inputMap = input (
    id: 'inputMap', message: 'enter password', parameters: [
        password(defaultValue: 'value', description: '', name: 'VAULT_PASS')
])

// def userInput = input(
//  id: 'userInput', message: 'Let\'s promote?', parameters: [
//  [$class: 'TextParameterDefinition', defaultValue: 'uat', description: 'Environment', name: 'env']
// ])
 

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

    