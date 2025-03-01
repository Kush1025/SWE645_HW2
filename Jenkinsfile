pipeline {
    agent any
    
    environment {
        // Define environment variables
        DOCKER_HUB_CREDS = credentials('docker-credentials')
        IMAGE_NAME = 'kshah1025/img'
        IMAGE_TAG = '0.1'
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Get code from GitHub repository
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                // Build the Docker image
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                // Log in to Docker Hub
                sh "echo ${DOCKER_HUB_CREDS_PSW} | docker login -u ${DOCKER_HUB_CREDS_USR} --password-stdin"
                
                // Push the image
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                
                // Log out for security
                sh "docker logout"
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Apply Kubernetes manifests
                sh "kubectl apply -f k8s-deployment.yaml"
                sh "kubectl apply -f k8s-service.yaml"
            }
        }
    }
    
    post {
        always {
            // Clean up
            sh "docker system prune -f"
        }
    }
}
