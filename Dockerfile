# Dockerfile
# Utiliser le tag Java 17 le plus générique pour contourner les problèmes de manifeste
FROM openjdk:17 

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier l'artefact JAR du build Maven 
COPY target/student-management*.jar /app/app.jar

# Exposer le port par défaut de l'application
EXPOSE 8089

# Définir la commande d'exécution
ENTRYPOINT ["java", "-jar", "app.jar"]
