
// properties([ parameters: 
//  [$class: 'TextParameterDefinition', defaultValue: 'none', description: 'Ansible Vault Password', name: 'vaultpass']
// ])

def userInput = input(
 id: 'userInput', message: 'Enter Vault Password:', parameters: [
 [$class: 'TextParameterDefinition', defaultValue: 'uat', description: 'Environment', name: 'vaultpass']
])
 

node("DOCKER_BUILD") {
currentBuild.result = "SUCCESS"

    stage('Checkout') { // for display purposes
      // Get latest code from a GitHub repository
      checkout scm;
   }
   
   stage('Initalize'){
       //Get these from parameters later
       //mvnHome = tool 'Maven3.5.0' //Not there on jenkins
       env.DEPLOY_ENV = 'dev'
       env.VAULT_PASS = userInput["vaultpass"]
   }

stage("Deploy to ${env.DEPLOY_ENV}")
    {	
        sh '''
            $BASE_DIR/build_deploy_interactive.sh $env.DEPLOY_ENV $env.VAULT_PASS
            ''' 
    }
}
    