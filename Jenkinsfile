
input message: 'enter password', parameters: [password(defaultValue: 'value', description: '', name: 'VAULT_PASS')]
 

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
       env.VAULT_PASS = params.VAULT_PASS
   }

stage("Deploy to ${env.DEPLOY_ENV}")
    {	
        sh '''
            ./build_deploy_interactive.sh $env.DEPLOY_ENV $env.VAULT_PASS
            ''' 
    }
}
    