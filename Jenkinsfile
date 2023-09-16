pipeline {
    agent any
    
    stages {
        
        stage("Clone Code") {
            agent {
                node {
                    label 'master && dockerBuild' 
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
                    label 'dockerBuild'
                }
            }
            steps{
                echo "Building the image"
                sh "docker build -t aichatbot ."
            }
        }
    }
}