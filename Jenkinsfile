pipeline {
    environment{
    registry="kacemch/kacem"
    registryCredential='83ffc7a1-192e-4250-8139-f45ffdc2bf97'
    dokerImage="devops_esprit"
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
