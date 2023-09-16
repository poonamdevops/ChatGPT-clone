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
                git url:"https://github.com/SANDEEP-NAYAK/django-GPT-3.5-ChatBot.git", branch: "master"
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
                sh "docker build -t aichatbot ."
            }
        }
    }
}