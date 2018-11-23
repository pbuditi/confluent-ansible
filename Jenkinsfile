import java.text.SimpleDateFormat

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
   def mvnHome;
   def project_id;
   def artifact_id;
   def aws_s3_bucket_name;
   def aws_s3_bucket_region;
   def timeStamp;
   def baseDir;
   def deploy_env;
   def deploy_userid;

    stage('Checkout') { // for display purposes
      // Get latest code from a GitHub repository
      checkout scm;
   }
   
   stage('Initalize'){
       //Get these from parameters later
       //mvnHome = tool 'Maven3.5.0' //Not there on jenkins
	   timeStamp = getTimeStamp();
       baseDir = pwd();
	   currentBranch = env.BRANCH_NAME;
	   env.APP_BASE_DIR = pwd()
       env.DEPLOY_ENV = getEnvVar(baseDir,'DEPLOY_ENV')
       env.PROJECT_ID = getEnvVar(baseDir,'PROJECT_ID')
	   env.DEPLOY_USER_ID = getEnvVar(baseDir, 'DEPLOY_USER_ID')
       env.ANSIBLE_DEPLOY_USER_CRED = getEnvVar(baseDir,'ANSIBLE_DEPLOY_USER_CRED')
       env.ANSIBLE_BECOME_USER_CRED = getEnvVar(baseDir,'ANSIBLE_BECOME_USER_CRED')
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
def getTimeStamp(){
	def dateFormat = new SimpleDateFormat("yyyyMMddHHmm")
	def date = new Date()
	return dateFormat.format(date);
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