pipeline {
    agent any // Roda diretamente no nó do Jenkins, sem container

    tools {
        // Usa os nomes exatos que você configurou no passo anterior
        maven 'maven3' 
        jdk 'jdk17'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Compile') {
            steps {
                // O Jenkins agora sabe onde está o comando 'mvn'
                sh 'mvn -B -DskipTests clean package'
            }
        }

        stage('Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }
    }

    post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
        success {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}