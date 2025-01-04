pipeline {
    agent any

    environment {
        DOTNET_VERSION = '8.0.100'  // .NET versie om te installeren
        PATH = "C:\\Program Files\\dotnet;${env.PATH}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout de repository
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/Rickeggink/EasyDevOps.git',
                        credentialsId: 'github-access-token'
                    ]]
                ])
                // Toon de inhoud van de workspace
                echo 'Workspace directory structure:'
                bat 'dir /s'
            }
        }

        stage('Setup Environment') {
            steps {
                bat '''
                where dotnet >nul 2>nul
                if %ERRORLEVEL% neq 0 (
                    echo Installing .NET SDK...
                    powershell -Command "Invoke-WebRequest -Uri https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1"
                    powershell -ExecutionPolicy Bypass -File dotnet-install.ps1 --version %DOTNET_VERSION%
                ) else (
                    echo .NET SDK is already installed.
                )
                '''
            }
        }

        stage('Build Frontend') {
            steps {
                // Verander naar de juiste map 'frontend/EasyDevOps' en voer de build uit
                dir('frontend/EasyDevOps') {
                    echo 'Current directory contents:'
                    bat 'dir'  // Toont de inhoud van de frontend/EasyDevOps map
                    bat 'dotnet build EasyDevOps.csproj'  // Bouw het .csproj bestand
                }
            }
        }

        stage('Run Tests') {
            steps {
                // Verander naar de juiste map 'frontend/EasyDevOps' en voer de tests uit
                dir('frontend/EasyDevOps') {
                    bat 'dotnet test EasyDevOps.csproj'  // Voer de tests uit
                }
            }
        }

        stage('Run Application') {
            steps {
                // Verander naar de juiste map 'frontend/EasyDevOps' en voer de applicatie uit
                dir('frontend/EasyDevOps') {
                    bat 'dotnet run EasyDevOps.csproj'  // Voer de applicatie uit
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
