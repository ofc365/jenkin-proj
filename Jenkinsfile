pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/ofc365/jenkin-proj.git'
            }
        }

        stage('Clean Existing Containers') {
            steps {
                sh '''
                    echo "Stopping and removing existing container if exists..."
                    docker rm -f html_compose_app || true
                '''
            }
        }

        stage('Build and Run with Docker Compose') {
            steps {
                sh '''
                    echo "Running Docker Compose..."
                    docker-compose up -d --build
                '''
            }
        }
    }

    post {
        success {
            echo 'App deployed successfully on port 8082!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
