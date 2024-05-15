pipeline {
    agent any
    environment {

        DOCKER_IMG_NAME = "aichatbot:$BUILD_ID"
        ECR_REPO_URL = "331523302307.dkr.ecr.ap-south-1.amazonaws.com/aichatbot:latest"
        // KUBE_CONFIG = "/path/to/your/kubeconfig"
        CLUSTER_NAME = "My-cluster"
        // HELM_PATH = "/dockerNode/workspace/chatbot-pipeline/K8s"
         SONAR_PROJECT_KEY = "test" // Replace with your actual project key
        // SONAR_QUBE_SERVER_URL = "http://13.235.87.63:9000" // Replace with your SonarQube server URL
        // SONAR_TOKEN = "sqp_4245cd1408a6a67ba320875560778f7d92e2f5fe" // Replace with your SonarQube token
    }
    
    stages {
        
        stage("Clone Code") {
            
            steps{
                echo "Cloning the code"
                git credentialsId: 'githubCreds', url: 'https://github.com/SANDEEP-NAYAK/ChatGPT-clone.git', branch: 'master'
            }
        }

        stage('SonarQube analysis') {

            steps{

                def scannerHome = tool 'scanthroughsonar'; // must match the name of an actual scanner installation directory on your Jenkins build agent
                    withSonarQubeEnv(installationName: 'sonar-server', credentialsId: 'sonar-api') {
                 // If you have configured more than one global server connection, you can specify its name as configured in Jenkins
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
            
            }
        }
    

        // stage("Run Tests and Generate Coverage Report") {
        //     steps {
        //         sh "python -m unittest discover -s tests" // Adjust command based on your testing framework
        //         sh "coverage xml" // Generate coverage report (adjust if using a different tool)
        //     }
        // }

        // stage('SonarQube Analysis') {
        //     steps{
        //     // Assuming SonarQube scanner plugin is installed and configured
        //         sh """
        //             sonar-scanner \
        //             -Dsonar.projectKey=${env.SONAR_PROJECT_KEY} \
        //             -Dsonar.sources=. \
        //             -Dsonar.python.version=3  
        //             -Dsonar.python.coverage.reportPaths=coverage.xml \
        //             -Dsonar.host.url=${env.SONAR_QUBE_SERVER_URL} \
        //             -Dsonar.login=${env.SONAR_TOKEN}
        //         """
        //     }
        // }

    //     stage("Quality Gate Check") {
    //         steps {
    //             timeout(time: 1, unit: 'HOURS') {
    //             def qgStatus = waitForQualityGate(failPipeline: true)
    //             if (qgStatus != 'OK') {
    //             error "Pipeline failed due to quality gate failure: ${qgStatus}"
    //         }
    //     }
    //   }
    // }
            
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
