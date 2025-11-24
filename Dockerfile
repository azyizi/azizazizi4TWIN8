# Dockerfile
# Utiliser une image de base Java allégée pour l'exécution
FROM openjdk:17-jdk-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier l'artefact JAR du build Maven (supposant que le nom est student-management.jar)
# Le nom exact du fichier peut varier.
COPY target/student-management*.jar /app/app.jar

# Exposer le port par défaut de l'application (ex: 8080 pour Spring Boot)
EXPOSE 8089

# Définir la commande d'exécution
ENTRYPOINT ["java", "-jar", "app.jar"]
