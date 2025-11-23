# Usa uma imagem leve do Java 17
FROM eclipse-temurin:17-jdk-alpine

# Define o diretório de trabalho
WORKDIR /app

# Copia o JAR gerado pelo Maven para dentro da imagem
# IMPORTANTE: O nome do jar pode variar. O asterisco *.jar pega qualquer um.
COPY target/*.jar app.jar

# Expõe a porta padrão do Spring Boot
EXPOSE 8080

# Comando para iniciar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]