
pipeline {
    agent any
     environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "192.168.56.10:8081"
        NEXUS_REPOSITORY = "my-app"
        VERSION = "1.0-SNAPSHOT"
        NEXUS_CREDENTIAL_ID = "f3148557-fc2c-4b43-9630-0baa29917de9"
    }
    stages {
        stage('Cloning project') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', credentialsId: '917c9acc-ac4d-4111-9e91-73428fd9539e', url: 'https://github.com/Shaimaskima/Spring.git/'
                echo "-------------------Clone Stage Done ------------------------------- "
            }
        }
        stage("MAVEN CLEAN") {
            steps {
                script {
                    sh "mvn -X -Dmaven.test.failure.ignore=true clean"
                }
            }
        }
        stage("MAVEN COMPILE") {
            steps {
                script {
                    sh "mvn -X -Dmaven.test.failure.ignore=true compile"
                }
            }
        }
        stage("MAVEN TEST") {
            steps {
                script {
                    sh "mvn -Dmaven.test.failure.ignore=true test"
                }
            }
        }
        stage("MAVEN BUILD") {
            steps {
                script {
                    sh "mvn -Dmaven.test.failure.ignore=true clean package"
                }
            }
        }
        stage('MAVEN BUILD & DEPLOY TO NEXUS REPO') {
            steps {
                echo 'Hello World'
                nexusArtifactUploader artifacts: [[artifactId: 'tpAchatProject', classifier: '', file: 'target/tpAchatProject-1.0.jar', type: 'jar']], credentialsId: 'c4e9649d-5f97-4f24-9ced-184dbd641c2d', groupId: 'com.esprit.examen', nexusUrl: '192.168.56.11:8081/repository/maven-releases/', nexusVersion: 'nexus3', protocol: 'http', repository: 'nexusdeploymentrepo', version: '1.0'
            }
        }
        
    }    

}
