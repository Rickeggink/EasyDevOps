pipeline {
    agent any

    environment {
        DOTNET_VERSION = '8.0.100'  // .NET version to install
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the source code from the repository
                checkout scm
            }
        }

        stage('Setup Environment') {
            steps {
                // Install .NET SDK if it is not already installed
                sh '''
                if ! command -v dotnet &> /dev/null
                then
                    echo "Installing .NET SDK..."
                    curl -sSL https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh -o dotnet-install.sh
                    chmod +x dotnet-install.sh
                    ./dotnet-install.sh --version $DOTNET_VERSION
                fi
                '''
            }
        }

        stage('Build Frontend') {
            steps {
                // Navigate to the 'frontend' directory and run the 'dotnet build' command
                dir('frontend') {
                    sh 'dotnet build'
                }
            }
        }

        stage('Run Tests') {
            steps {
                // Navigate to the 'frontend' directory and run the 'dotnet test' command
                dir('frontend') {
                    sh 'dotnet test'
                }
            }
        }

        stage('Run Application') {
            steps {
                // Navigate to the 'frontend' directory and run the 'dotnet run' command
                dir('frontend') {
                    sh 'dotnet run'
                }
            }
        }
    }

    post {
        success {
            // Post success actions
            echo 'Pipeline executed successfully!'
        }
        failure {
            // Post failure actions
            echo 'Pipeline failed!'
        }
    }
}
