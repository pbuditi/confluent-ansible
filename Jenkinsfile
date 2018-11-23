
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
        run_playbook("$env.DEPLOY_ENV", "$env.VAULT_PASS" );
    }

  } catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }
}
def run_playbook(String deploy_env, String vaultpass) {
		withEnv(["BASE_DIR=${baseDir}","DEPLOY_ENV=${deploy_env}"])
        {
                sh '''
                $BASE_DIR/build_deploy_interactive.sh $DEPLOY_ENV $vaultpass
                '''
		}
}
def getEnvVar(String baseDir, String varName){
  def val = sh (script: "grep '${varName}' ${baseDir}/env_vars/project.properties|cut -d'=' -f2", returnStdout: true).trim();
  return val;
}