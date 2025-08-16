pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'   // your region
        AWS_ACCOUNT_ID = '791608741441'     // replace with your account ID
        ECR_REPO = 'flask-app'
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/youruser/flask-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${ECR_REPO}:${IMAGE_TAG}")
                }
            }
        }

        stage('Login to ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-ecr-creds']]) {
                    sh '''
                        aws ecr get-login-password --region $AWS_DEFAULT_REGION \
                        | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
                    '''
                }
            }
        }

        stage('Tag & Push to ECR') {
            steps {
                script {
                    sh '''
                        docker tag ${ECR_REPO}:${IMAGE_TAG} $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}
                        docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}
                    '''
                }
            }
        }
    }
}
