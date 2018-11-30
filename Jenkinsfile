
def NEXUSARTIFACTS = [
    GROUP_NAME          : "cp-confluent",
    GROUP_NAME_NO_PATH  : "cp-confluent",
    FILENAME            : "cp-confluent",
    REPOSITORY_NAME     : "RIO",
    FILE_PREFIX         : "",
    NEXUS_URL           : "nexuscimgmt.sgp.dbs.com:8443/nexus",
]

pipeline {
  // environment {
  //   GIT_COMMIT_HASH = sh (script: "git rev-parse --short HEAD", returnStdout: true)
  //   GIT_MSG = sh (script: "git log --format='medium' -1 ", returnStdout: true)
  // }
  parameters {
    password(name: 'VAULT_PASS', defaultValue: 'vaultpass', description: 'Enter VAULT_PASS')
    choice(name: 'rioenv', choices:'dev\nuat\nprod', description: 'Which Environment' )
  }

  agent {
    label 'DOCKER_BUILD'
  }

  options {
      timeout(time: 1, unit: 'HOURS')
      disableConcurrentBuilds()
  }

  stages {
    stage('Init'){
      steps{
          script {
            env.APP_BASE_DIR = pwd()
            env.CURRENT_BRANCH = env.BRANCH_NAME
            env.DEPLOY_ENV = "${params.DEPLOY_ENV}"
            env.REPO_PASS = "${params.REPO_PASS}"
            PROJECT_ID = 'RIO'
            GIT_COMMIT_HASH = sh (script: "git rev-parse --short HEAD", returnStdout: true).trim()
            GIT_MSG = sh (script: "git log --format='medium' -1 ", returnStdout: true).trim()
            env.GIT_COMMIT_HASH = sh (script: "git rev-parse HEAD", returnStdout: true).trim()
            env.GIT_COMMIT_SHORT_HASH = sh (script: "git rev-parse --short HEAD", returnStdout: true).trim()
          }
      }
    }
    stage('Package'){
      steps{
      //  sh "mkdir ${APP_BASE_DIR}/release"
        sh "cd ${APP_BASE_DIR}/src && tar -czvf ${APP_BASE_DIR}/release/${PROJECT_ID}-${GIT_COMMIT_SHORT_HASH}.tar.gz ."
      }
    }
    stage('Publish'){
      steps{
          nexusArtifactUploader artifacts: [
                        [artifactId: "${PROJECT_ID}-${GIT_COMMIT_SHORT_HASH}.tar.gz", file: "${APP_BASE_DIR}/release/${PROJECT_ID}-${GIT_COMMIT_SHORT_HASH}.tar.gz"]],
                        credentialsId: 'nexusArtifactUploader',
                        groupId: "com.dbs.${NEXUSARTIFACTS.GROUP_NAME_NO_PATH}",
                        nexusUrl: "${NEXUSARTIFACTS.NEXUS_URL}",
                        nexusVersion: 'nexus3',
                        protocol: 'https',
                        repository: "${NEXUSARTIFACTS.REPOSITORY_NAME}",
                        version: "${NEXUSARTIFACTS.FILE_PREFIX}${env.BUILD_NUMBER}"
                
      }
    }
    stage('Deploy'){
      steps{
       // sh "echo ./build_deploy_interactive.sh ${DEPLOY_ENV} ${VAULT_PASS}"
        sh "./src/build_deploy_interactive.sh ${DEPLOY_ENV} ${VAULT_PASS}"
      }
    }
    stage('Create Release Request') {
      steps{ 
        createjiraticket([
          "projectKey":"RIO",
          "branch":"master",
          "commitID":"a01237cc0b2",
          "summary":"deploy ",
          'APP_VERSION':"1",
          'CD Deployment Type':"CD-RA",
          'Nexus Artifact ID':"cp-ansible",
          'Nexus Group ID':"com.dbs.rio",
          "Repo URL":"https://bitbucket.sgp.dbs.com:8443/dcifgit/scm/rio"])
       }
    }
  }
}