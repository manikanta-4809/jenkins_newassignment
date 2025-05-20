pipeline {
    agent any

    environment {
        VENV = 'venv'
    }

    stages {
        stage ("Install") {
            steps {
                sh '''
                    python3 -m venv $VENV
                    . $VENV/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }
        stage ("Linting") {
            steps {
                script {
                    echo "This is my Linting Step"
                }
            }
        }
        stage ("Install Packages") {
            steps {
                script {
                    echo "This is Install PAkcges Step"
                }
            }
        }
        stage ("Run Application") {
            steps {
                script {
                    echo "This is my Run applcaition Step"
                }
            }
        }

    }
}