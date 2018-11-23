
// properties([ parameters: 
//  [$class: 'TextParameterDefinition', defaultValue: 'none', description: 'Ansible Vault Password', name: 'vaultpass']
// ])

def userInput = input(
 id: 'userInput', message: 'Enter Vault Password:', parameters: [
 [$class: 'TextParameterDefinition', defaultValue: 'uat', description: 'Environment', name: 'vaultpass']
])
 
echo "${params.MYOPTION}"

node("DOCKER_BUILD") {
currentBuild.result = "SUCCESS"
  try{


    stage('Checkout') { // for display purposes
      // Get latest code from a GitHub repository
      checkout scm;
   }
   
   stage('Initalize'){
       //Get these from parameters later
       //mvnHome = tool 'Maven3.5.0' //Not there on jenkins
       baseDir = pwd();
	   currentBranch = env.BRANCH_NAME;
	   env.APP_BASE_DIR = pwd()
       env.DEPLOY_ENV = getEnvVar(baseDir,'DEPLOY_ENV')
       env.VAULT_PASS = userInput["vaultpass"]

   }

stage("Deploy to ${env.DEPLOY_ENV}")
    {	
            withEnv(["BASE_DIR=${baseDir}","DEPLOY_ENV=${deploy_env}"])
            {
                    sh '''
                    $BASE_DIR/build_deploy_interactive.sh $env.DEPLOY_ENV $env.VAULT_PASS
                    '''
            } 
    }

  } catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }
}
