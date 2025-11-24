# Dockerfile
# Utiliser une image de base Java allégée pour l'exécution
# ⚠️ CORRECTION : Remplacer le tag '17-jdk-slim' par un tag plus sûr
FROM openjdk:17-jdk-slim-buster
# OU openjdk:17-jdk-slim-buster (si 17-slim ne fonctionne pas)

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier l'artefact JAR du build Maven 
COPY target/student-management*.jar /app/app.jar

# Exposer le port par défaut de l'application
EXPOSE 8089

# Définir la commande d'exécution
ENTRYPOINT ["java", "-jar", "app.jar"]
