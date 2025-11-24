# Dockerfile
# Utiliser le registre Eclipse Temurin (souvent plus fiable que openjdk:XX direct)
FROM eclipse-temurin:17-jre-focal
# '17-jre-focal' donne Java Runtime Environment 17 basé sur Ubuntu Focal (20.04)
# C'est l'équivalent stable et spécifique de 'openjdk:17-slim'

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier l'artefact JAR du build Maven 
COPY target/student-management*.jar /app/app.jar

# Exposer le port par défaut de l'application
EXPOSE 8089

# Définir la commande d'exécution
ENTRYPOINT ["java", "-jar", "app.jar"]
