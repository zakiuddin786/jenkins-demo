pipeline {
    agent any 
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

        //  build the frontend

        // deploy
    }
}