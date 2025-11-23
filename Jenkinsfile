pipeline {
    agent any

    tools {
        maven 'maven3' 
        jdk 'jdk17'
    }

    environment {
        // Nome da imagem e do container para facilitar
        IMAGE_NAME = "minha-app-spring"
        CONTAINER_NAME = "minha-app-container"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build JAR') {
            steps {
                echo 'Compilando com Maven...'
                // Pula testes para ser mais rápido no exemplo
                sh 'mvn clean package -DskipTests' 
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Criando imagem Docker...'
                // O ponto final (.) diz para usar o Dockerfile da pasta atual
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Deploy') {
            steps {
                echo 'Implantando Container...'
                script {
                    // 1. Tenta parar e remover o container antigo (se existir)
                    // "|| true" serve para não falhar o build se o container não existir ainda
                    sh "docker rm -f ${CONTAINER_NAME} || true"

                    // 2. Sobe o novo container
                    // -d: Background
                    // -p 8090:8080: Acessaremos no Windows via localhost:8090 (mapeia para a 8080 interna do Java)
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8090:8080 ${IMAGE_NAME}"
                }
            }
        }
    }
}