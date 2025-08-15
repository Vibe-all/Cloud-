pipeline {
    agent any
environment {
    IMAGE_NAME = 'Vibe-all/Cloud-'
}
stages{
     stage('Checkout'){
        steps{
           git branch: 'main', url: 'https://github.com/Vibe-all/Cloud-'
        }
     }
    stage('Build Docker image'){
        steps{
            bat "docker build -t %IMAGE_NAME%:latest ."
        }
    }
    stage('Push to Dockerhub'){
        steps{
            withCredentials([usernanmePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){
                bat """
                echo %DOCKER_PASS% |
                docker login -u %DOCKER_USER% --password-stdin
                docker push %IMAGE_NAME%:latest
                docker logout 
                """
            }
        }
        
            }
        }
}
