pipeline {
    agent none
    environment {
        NEXUS_REGISTRY_URL = 'http://54.196.98.221:8085/'
        DOCKER_IMG_NAME = "aichatbot:$BUILD_ID"
    }
    
    stages {
        
        stage("Clone Code") {
            agent {
                node {
                    label 'dockerNode' 
                }
            }
            steps{
                echo "Cloning the code"
                git url:'https://github.com/SANDEEP-NAYAK/django-GPT-3.5-ChatBot.git', branch: 'master'
            }
        }
            
        stage("Build") {
            agent {
                node {
                    label 'dockerNode'
                }
            }
            steps{
                echo "Building the image"
                sh "docker build -t ${DOCKER_IMG_NAME} ."
                
            }
        }

        stage ("Pushing To Nexus Docker Private Repository"){
            agent {
                node {
                    label 'dockerNode'
                }
            }

            steps {
                echo "Pushing to Nexus"
                withCredentials([usernamePassword(credentialsId: "NEXUS_CREDENTIALS_ID", usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASSWORD')]) {
                    sh "docker login -u ${NEXUS_USERNAME} -p ${NEXUS_PASSWORD} ${NEXUS_REGISTRY_URL}"
                    sh "docker push ${DOCKER_IMG_NAME}"
                }                
            }
        }
    }
}
