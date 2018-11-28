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
            env.DEPLOY_ENV = "${params.rioenv}"
            env.VAULT_PASS = "${params.VAULT_PASS}"
          }
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
    stage('Deploy'){
      steps{
       // sh "echo ./build_deploy_interactive.sh ${DEPLOY_ENV} ${VAULT_PASS}"
        sh "./build_deploy_interactive.sh ${DEPLOY_ENV} ${VAULT_PASS}"
      }
    }
  }
}