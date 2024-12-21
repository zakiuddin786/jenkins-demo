pipeline {
    agent any 
    environment {
        beta_access_key = credentials("beta_access_key")
        beta_secret_access_key = credentials("beta_secret_access_key")
        prod_access_key = credentials("prod_access_key")
        prod_secret_access_key = credentials("prod_secret_access_key")
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
                    sh "npm ci"
                }

                dir("todo-frontend"){
                    echo "Installing the frontend dependencies"
                    sh "npm ci"
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
                echo "Deploying to Beta stage"
                sh "./deploy.sh beta ${beta_access_key} ${beta_secret_access_key}"
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