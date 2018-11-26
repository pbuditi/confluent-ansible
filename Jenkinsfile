pipeline {
  environment {
    GIT_COMMIT_HASH = sh (script: "git rev-parse --short HEAD", returnStdout: true)
    GIT_MSG = sh (script: "git log --format='medium' -1 ", returnStdout: true)
  }
  parameters {
    password(name: 'VAULT_PASS', defaultValue: 'vaultpass', description: 'Enter VAULT_PASS')
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
            env.DEPLOY_ENV = 'dev'
            env.VAULT_PASS = "${VAULT_PASS}"
          }
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