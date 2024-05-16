pipeline {
    agent any
    environment {
        DOCKER_IMG_NAME = "aichatbot:$BUILD_ID"
        ECR_REPO_URL = "331523302307.dkr.ecr.ap-south-1.amazonaws.com/aichatbot:latest"
        CLUSTER_NAME = "My-cluster"
        SONAR_PROJECT_KEY = "test" // Replace with your actual project key
    }
    
    
    stages {
        stage("Clone Code") {
            steps {
                echo "Cloning the code"
                git credentialsId: 'githubCreds', url: 'https://github.com/SANDEEP-NAYAK/ChatGPT-clone.git', branch: 'master'
            }
        }

        stage('SonarQube analysis') {
            steps {
                script {
                    def scannerHome = tool name: 'scanthroughsonar', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                    withSonarQubeEnv('sonar-server') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage("Quality Gate") {

            steps {
                timeout(time: 1, unit: 'HOURS') {

                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage("Build") {
            steps {
                echo "Building the image"
                sh "docker build -t ${DOCKER_IMG_NAME} ."
            }
        }

        stage("Pushing To Elastic Container Registry") {
            steps {
                echo "Pushing to ECR"
                sh "docker tag ${DOCKER_IMG_NAME} ${ECR_REPO_URL}"
                sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 331523302307.dkr.ecr.ap-south-1.amazonaws.com"
                sh "docker push ${ECR_REPO_URL}"
                echo "Image Pushed Successfully..."
            }
        }
    }
}
  
