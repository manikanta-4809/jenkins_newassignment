pipeline {
    agent any

    environment {
        VENV = 'venv'
        DOCKER_IMAGE = 'manikanta4809/jenkins_newassignment'
        TAG = 'latest'
    }

    stages {
        stage("Install Dependencies") {
            steps {
                script {
                    sh 'python3 -m venv $VENV'
                    sh '. $VENV/bin/activate && pip install --upgrade pip'
                    sh '. $VENV/bin/activate && pip install -r requirements.txt'
                }
            }
        }

        stage("Linting") {
            steps {
                echo "Running lint checks"
                sh '''
                    . $VENV/bin/activate
                    echo "Checking if flake8 is installed..."
                    which flake8 | tee /dev/tty

                    echo "Listing files in app/ directory..."
                    ls -R app/ | tee /dev/tty

                    echo "Running flake8 linter..."
                    flake8 app/ | tee /dev/tty
                '''
            }
        }

        stage("Testing") {
            steps {
                script {
                    echo "Running tests"
                    sh '. $VENV/bin/activate && pytest tests/'
                }
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    echo "Building Docker Image"
                    sh 'docker build -t $DOCKER_IMAGE:$TAG .'
                }
            }
        }

        stage("Push to DockerHub") {
            steps {
                script {
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
}
