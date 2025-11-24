// Jenkinsfile
pipeline {
    agent any
    
    tools {
        // Noms d'outils corrigés (selon l'Atelier 1)
        jdk 'JAVA-HOME' 
        maven 'M2 HOME' 
    }

    // REMPLACER par votre nom d'utilisateur Docker Hub exact
    def dockerHubUser = 'azizi02k' 

    stages {
        stage('Clean and Build') {
            steps {
                echo 'Nettoyage et construction du projet Maven...'
                // Utilisation de -DskipTests pour contourner l'erreur de base de données
                sh 'mvn clean install -DskipTests' 
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo "Construction de l'image Docker: ${dockerHubUser}/student-management:latest"
                // Construit l'image en utilisant le Dockerfile à la racine ('.')
                sh "docker build -t ${dockerHubUser}/student-management:latest ." 
            }
        }
        
        stage('Push Docker Image to Docker Hub') {
            // Utilise l'ID de credential 'docker-hub-credentials' configuré dans Jenkins
            withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                steps {
                    echo "Connexion à Docker Hub..."
                    // Connexion sécurisée en passant le mot de passe via l'entrée standard
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    
                    echo "Poussée de l'image Docker vers Docker Hub..."
                    sh "docker push ${dockerHubUser}/student-management:latest"
                    
                    echo "Déconnexion de Docker Hub"
                    sh "docker logout"
                }
            }
        }
    }
}
