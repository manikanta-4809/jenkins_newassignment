pipeline {
    agent any
 
    environment {
        VENV = 'venv'
        DOCKER_IMAGE = 'manikanta4809/pyjen-app'
        TAG = 'latest'
    }
 
    stages {
        stage("Install") {
            steps {
                sh '''
                    python3 -m venv $VENV
                    . $VENV/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }
 
        stage("Linting") {
            steps {
                echo "Running lint checks"
                sh '''
                    . $VENV/bin/activate
                    flake8 py.jen/
                '''
            }
        }
 
        stage("Testing") {
            steps {
                echo "Running tests"
                sh '''
                    . $VENV/bin/activate
                    pytest --cov=py.jen
                '''
            }
        }
 
        stage("Build Docker Image") {
            steps {
                echo "Building Docker Image"
                sh "docker build -t $DOCKER_IMAGE:$TAG ."
            }
        }
 
        stage("Push to DockerHub") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_IMAGE:$TAG
                        docker logout
                    '''
                }
            }
        }
    }
}