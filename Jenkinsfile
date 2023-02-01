pipeline {
    environment{
    registry="chaimask/chaima"
    registryCredential='e1451ab0-a0bb-45c5-9f5c-c30f0b267fbb'
    dokerImage="devops_container"
}
    agent any
    stages {
        stage('Cloning the project') {
            steps {
                // clone from git and test trigger
                git branch: 'main', credentialsId: '15abb24f-d15c-4109-b679-858a4caa469f', url: 'https://github.com/kacemch/Devops_kacem.git'
                echo "-------------------Clone Stage Done ------------------------------- "
            }
        }
        stage("clean"){
            steps {
                script {
                    sh "mvn -Dmaven.test.failure.ignore=true clean"
                }
            }
        }
        stage("compile") {
            steps {
                script {
                    sh "mvn -Dmaven.test.failure.ignore=true compile"
                }
            }
        }
        stage("test") {
            steps {
                script {
                    sh "mvn -Dmaven.test.failure.ignore=true test"
                }
            }
        }
        stage("build") {
            steps {
                script {
                    sh "mvn -Dmaven.test.failure.ignore=true clean package"
                }
            }
        }
        stage("docker build") {
                       steps{
                         script {
                            dockerImage = docker.build registry +":$BUILD_NUMBER"
                       }
                 }
       }
        
        stage("docker push") {
              steps{
                 script {
                 withDockerRegistry(credentialsId: registryCredential) {
                  dockerImage.push()
                  }
                }
           }
        }
        stage('Cleaning up') {
             steps{
             sh "docker rmi $registry:$BUILD_NUMBER"
        }
    }
    stage('running containers'){
        steps{
            sh 'docker-compose up -d'
        }
    }
        
    }    

}
