pipeline {
    agent any
    environment {

        DOCKER_IMG_NAME = "aichatbot:$BUILD_ID"
        ECR_REPO_URL = "331523302307.dkr.ecr.ap-south-1.amazonaws.com/aichatbot:latest"
        // KUBE_CONFIG = "/path/to/your/kubeconfig"
        CLUSTER_NAME = "My-cluster"
        // HELM_PATH = "/dockerNode/workspace/chatbot-pipeline/K8s"
    }
    
    stages {
        
        stage("Clone Code") {
            
            steps{
                echo "Cloning the code"
                git credentialsId: 'githubCreds', url: 'https://github.com/SANDEEP-NAYAK/ChatGPT-clone.git', branch: 'master'
            }
        }

        stage('SonarQube Analysis') {

            steps{
                sonar-scanner \
                -Dsonar.projectKey=test \
                -Dsonar.sources=. \
                -Dsonar.host.url=http://13.235.87.63:9000 \
                -Dsonar.token=sqp_4245cd1408a6a67ba320875560778f7d92e2f5fe
            }
            
  }
            
        stage("Build") {
           
            steps{
                echo "Building the image"
                sh "docker build -t ${DOCKER_IMG_NAME} ."
                
            }
        }

        


        stage("Pushing To Elastic Containar Registry"){
         

            steps{
                echo "Pushing to ECR"
                sh "docker tag ${DOCKER_IMG_NAME} ${ECR_REPO_URL}"
                sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 331523302307.dkr.ecr.ap-south-1.amazonaws.com"
                sh "docker push ${ECR_REPO_URL}"
                echo "Image Pushed Successfully..."
            }
        }

        // stage ("Deploying in EKS using helm"){
           
        //     steps {
        //        echo "Updating kubectl configuration for EKS cluster"
        //        sh "aws eks update-kubeconfig --region us-east-1 --name ${CLUSTER_NAME}"
               
        //        sh "helm lint ${HELM_PATH}"
        //        sh "helm install chatbot-app ${HELM_PATH}"
        //        echo "Applied Kubernetes deployment using helm charts"
        //        sh "kubectl get ingress"
        //        //sh "kubectl apply -f ${REPO_PATH}/K8s/manifest.yaml"
        //     }
        // }
    }
}
