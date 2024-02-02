#Application Overview
This is a django based ChatGPT clone Application. It has authentication feature, login, logout, register. 
![image](https://github.com/SANDEEP-NAYAK/django-GPT-3.5-ChatBot/assets/77114339/0d229dc6-b67f-4989-aac6-2b0e5608a9a0)
![image](https://github.com/SANDEEP-NAYAK/django-GPT-3.5-ChatBot/assets/77114339/d94b5e58-a3ad-4786-8623-c04c75d62eb6)

what it does is basically after logging in you can enter any query and in the backend the application is using GPT 3.5 model and the query is responded to user after it has been processed by the model.
The model is integrated by using the OpenAI API key.

#The whole CI/CD Automation part:
The code is pushed into github, github webhook is setupd which triggers the pipeline automatically when a new code is pushed to the repo.
The jenkins have one slave named dockerNode which houses docker and K8s tools reuqired to interact with the cluster.
The code is pulled into the dockerNode and then image is built out of it.
The image is then tagged accordingly and is pushed into AWS ECR.
Then the EKS cluster has been setup using eksctl command 
eg: eksctl create cluster --name Rinc-cluster --region us-east-1 --nodegroup-name Rinc-nodegroup1 --nodes 2 --nodes-min 2 --nodes-max 3 --node-type t3.xlarge --vpc-public-subnets=subnet-0b50ddaee2708a164,subnet-05f243aea35a74550,subnet-05ea203e9ea864722
And now the manifest.yaml file is deployed automatically onto the cluster via the Jenkins script itself.
It uses AWS ALB as the LoadBalancer.
The service has been exposed on port 80.
The container is exposed on port 8000.
![Screenshot 2024-02-02 132937](https://github.com/SANDEEP-NAYAK/django-GPT-3.5-ChatBot/assets/77114339/7fd3ffe9-4411-4b45-b027-e137edab4c8e)
