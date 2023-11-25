pipeline {
    agent none
    
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
                // sh 'docker build -t aichatbot:$BUILD_ID .'
                
            }
        }

        stage ("Push To DockerHub"){
            agent {
                node {
                    label 'dockerNode'
                }
            }

            steps {
                echo "Pushing to dockerHub"
                withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB_CREDENTIALS', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh "docker login -u ${env.DOCKER_USERNAME} -p ${env.DOCKER_PASSWORD}"
                    // sh "docker push sandeepdarkworld/aichatbot:$BUILD_ID"
                    // sh 'docker image tag aichatbot:$BUILD_ID sandeepdarkworld/aichatbot:$BUILD_ID'
                    sh "docker pull hello-world"
                    sh "docker tag hello-world ${env.DOCKER_USERNAME}/hello-world"
                    sh "docker image push ${env.DOCKER_USERNAME}/hello-world"
                }
            }
        }
    }
}