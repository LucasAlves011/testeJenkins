pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Esta etapa realiza o checkout do código do repositório
                checkout scm
            }
        }

        stage('Build') {
            steps {
                // Execute os passos de construção aqui
                sh 'mvn clean package'
            }
        }

        stage('Deploy') {
            steps {
                // Execute os passos de deploy aqui (subindo o projeto)
                // Substitua o comando abaixo com o comando específico para subir seu projeto
                sh 'java -jar target/testeJenkins-0.0.1-SNAPSHOT.jar &'
            }
        }
    }

    post {
        success {
            echo 'O job foi concluído com sucesso.'
        }
        failure {
            echo 'O job falhou.'
        }
    }
}
