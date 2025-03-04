pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDS = credentials('docker_credentials')
        DOCKER_IMAGE = 'kshah1025/img'
        DOCKER_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Kush1025/SWE645_HW2.git', branch: 'main'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                sh 'echo $DOCKER_HUB_CREDS_PSW | docker login -u $DOCKER_HUB_CREDS_USR --password-stdin'
                sh 'docker push ${DOCKER_IMAGE}:${DOCKER_TAG}'
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl set image deployment/deployment1 studentsurvey=${DOCKER_IMAGE}:${DOCKER_TAG}'
            }
        }
    }
    
    post {
        always {
            sh 'docker logout'
        }
    }
}
