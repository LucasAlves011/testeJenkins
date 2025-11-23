pipeline {
    agent {
        docker {
            // Usa uma imagem oficial do Maven com JDK 17 (ajuste a versão do JDK conforme seu projeto)
            image 'maven:3.9.6-eclipse-temurin-17' 
            // Mapeia o cache do Maven para o host para acelerar builds futuros
            args '-v $HOME/.m2:/root/.m2' 
        }
    }

    options {
        // Mantém apenas os últimos 5 builds no histórico para economizar espaço
        buildDiscarder(logRotator(numToKeepStr: '5'))
        // Adiciona timestamp nos logs
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                // Baixa o código do repositório (automático em Multibranch, mas bom explicitar)
                checkout scm
            }
        }

        stage('Build & Compile') {
            steps {
                echo 'Compilando o projeto...'
                // -B: Batch mode (menos logs inúteis)
                // -DskipTests: Pula os testes nesta etapa para ser mais rápido
                sh 'mvn -B -DskipTests clean package'
            }
        }

        stage('Unit Tests') {
            steps {
                echo 'Executando testes unitários...'
                sh 'mvn test'
            }
        }

        stage('Quality Analysis') {
             // Opcional: Se tiver SonarQube
             when { branch 'main' } 
             steps {
                 echo 'Pulando SonarQube por enquanto (configure aqui se tiver)'
                 // sh 'mvn sonar:sonar'
             }
        }
    }

    post {
        always {
            // Gera relatórios de testes (JUnit) para o Jenkins exibir gráficos
            junit 'target/surefire-reports/*.xml'
        }
        success {
            // Arquiva o JAR gerado para download ou uso em deploy
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            echo 'Build com Sucesso!'
        }
        failure {
            echo 'O build falhou. Verifique os logs.'
        }
    }
}