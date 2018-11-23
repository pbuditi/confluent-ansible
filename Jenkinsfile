
input message: 'enter password', parameters: [password(defaultValue: 'value', description: '', name: 'VAULT_PASS')]
 

node("DOCKER_BUILD") {
currentBuild.result = "SUCCESS"
def environment = 'dev'
def vault_password = ''

    stage('Checkout') { // for display purposes
      // Get latest code from a GitHub repository
      checkout scm;
   }
   
   stage('Initalize'){
       //Get these from parameters later
       //mvnHome = tool 'Maven3.5.0' //Not there on jenkins
       environment = 'dev'
       vault_password = params.VAULT_PASS
   }

stage("Deploy to ${environment}")
    {	
        sh '''
             echo ./build_deploy_interactive.sh $environment $vault_password
            ./build_deploy_interactive.sh $environment $vault_password
            ''' 
    }
}
    