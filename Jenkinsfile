pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/ofc365/jenkin-proj.git'
            }
        }

        stage('Stop Previous Containers') {
            steps {
                script {
                    sh 'docker-compose down || true'
                }
            }
        }

        stage('Build and Run with Docker Compose') {
            steps {
                script {
                    sh 'docker-compose up -d --build'
                }
            }
        }
    }

    post {
        success {
            echo 'App deployed successfully at port 8080!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
