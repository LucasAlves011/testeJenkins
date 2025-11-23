pipeline {
    agent any 

    tools {
        // Configure estes nomes em "Manage Jenkins > Tools" antes de rodar!
        maven 'maven3' 
        jdk 'jdk17'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                // Roda usando o Maven configurado no Jenkins
                sh 'mvn clean package -DskipTests' 
            }
        }
        stage('Tests') {
            steps {
                sh 'mvn test'
            }
        }
    }
}