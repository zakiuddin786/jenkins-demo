pipeline {
    agent any 
    environment {
        REGION = "ap-south-1"
    }
    stages {
        // checkout the code
        stage("Checkout of the Code ") {
            steps{
                // clone the repo
                // git branch: "main", url: "https://github.com/zakiuddin786/jenkins-demo"
                echo "Checking out repo"
                checkout scm
            }
        }

        stage("Installation of dependencies"){
            steps {
                dir("todo-backend"){
                    echo "Installing the backend dependencies"
                    sh "npm install"
                }

                dir("todo-frontend"){
                    echo "Installing the frontend dependencies"
                    sh "npm install"
                }
            }
        }

        stage("Run tests"){
            steps{
                parallel (
                    backendTests: {
                        dir("todo-backend") {
                        echo "Running the backend test cases"
                        sh "npm test"
                        }
                    },
                    frontendTests: {
                        dir("todo-frontend") {
                        echo "Running the frontend test cases"
                        sh "npm test"
                        }
                    }
                )
            }
        }

        stage("Build Frontend"){
            steps {
                dir("todo-frontend") {
                    echo "Building the frontend"
                    sh "npm run build"
                }
            }
        }

        stage("Beta Deployment"){
            steps {
                withCredentials([
                    string(credentialsId: 'beta_access_key', variable: 'AWS_ACCESS_KEY'),
                    string(credentialsId: 'beta_secret_access_key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    script{
                        echo "Deploying to Beta stage"
                        sh "chmod +x -R ./deploy.sh"
                        sh "./deploy.sh beta ${AWS_ACCESS_KEY} ${AWS_SECRET_ACCESS_KEY}"
                    }
                }
            }
        }
        // deploy
    }

    post {
        success {
            echo "Pipeline executed successfully!"
        }
        failure{
            echo "Pipeline failed"
        }
        always {
            echo "pipeline execution finished, cleaning workspace"
            cleanWs()
        }
    }

}