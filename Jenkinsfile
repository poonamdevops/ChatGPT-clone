pipeline {
    agent none
    environment {
        // NEXUS_REGISTRY_URL = 'https://localhost:6666/'
        DOCKER_IMG_NAME = "aichatbot:$BUILD_ID"
        // SHELL_DIR = "/dockerNode/workspace/chatbotApp/nexus_secure"
        ECR_REPO_URL = "991486635617.dkr.ecr.us-east-1.amazonaws.com/chatobott-img:latest"
        KUBE_CONFIG = "/path/to/your/kubeconfig"
        REPO_PATH = "/dockerNode/workspace/chatbot-pipeline"
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

        stage ("Pushing To Elastic Containar Registry"){
            agent {
                node {
                    label 'dockerNode'
                }
            }

            steps{
                echo "Pushing to ECR"
                sh "docker build -t chatobott-img ."
                sh "docker tag chatobott-img:latest ${ECR_REPO_URL}"
                sh "docker push ${ECR_REPO_URL}"
                echo "Image Pushed Successfully..."
            }

        stage ("Deploying the in EKS"){
            agent {
                node {
                    label 'dockerNode'
                }
            }

            steps {
               echo "Updating kubectl configuration for EKS cluster"
               sh "aws eks update-kubeconfig --region us-east-1 --name chatbot-cluster"
                
               echo "Applying Kubernetes deployment"
               sh "kubectl apply -f ${REPO_PATH}/k8s/manifest.yaml"

               echo "Waiting for the deployment to complete"
               sh "kubectl wait --timeout=120s --for=condition=Ready ingress/chatbot-ingress"
            }
        }
        
    }
}