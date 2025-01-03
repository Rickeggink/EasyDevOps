pipeline {
    agent any

    environment {
        DOTNET_VERSION = '8.0.100'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clone je GitHub-repository
                checkout scm
            }
        }

        stage('Setup Environment') {
            steps {
                // Installeer .NET SDK als het niet beschikbaar is
                sh '''
                if ! command -v dotnet &> /dev/null
                then
                    echo "Installing .NET SDK..."
                    wget https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh
                    chmod +x dotnet-install.sh
                    ./dotnet-install.sh --version $DOTNET_VERSION
                fi
                '''
            }
        }

        stage('Build Frontend') {
            steps {
                dir('frontend') {
                    sh 'dotnet build'
                }
            }
        }

        stage('Run Tests') {
            steps {
                dir('frontend') {
                    sh 'dotnet test'
                }
            }
        }

        stage('Run Application') {
            steps {
                dir('frontend') {
                    sh 'dotnet run'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline uitgevoerd met succes!'
        }
        failure {
            echo 'Pipeline mislukt!'
        }
    }
}
