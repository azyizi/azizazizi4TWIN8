// Jenkinsfile (CORRIGÉ)
pipeline {
    agent any
    
    // NOUVEAU : Définir la variable dans le bloc environment pour un pipeline déclaratif
    environment {
        DOCKER_USER_NAME = 'azizi02k' // <-- Assurez-vous que c'est bien votre nom d'utilisateur Docker Hub
    }

    tools {
        jdk 'JAVA HOME' 
        maven 'M2_HOME' 
    }

    stages {
        stage('Clean and Build') {
            steps {
                echo 'Nettoyage et construction du projet Maven...'
                sh 'mvn clean install -DskipTests' 
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo "Construction de l'image Docker: ${env.DOCKER_USER_NAME}/student-management:latest"
                sh "docker build -t ${env.DOCKER_USER_NAME}/student-management:latest ." 
            }
        }
        
        stage('Push Docker Image to Docker Hub') {
            // ATTENTION : Le bloc withCredentials DOIT être DANS le bloc steps { ... }
            steps {
                // Utilise l'ID de credential 'docker-hub-credentials' configuré dans Jenkins
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    
                    echo "Connexion à Docker Hub..."
                    // Utilisation de la variable d'environnement DOCKER_USER et DOCKER_PASS fournies par withCredentials
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    
                    echo "Poussée de l'image Docker vers Docker Hub..."
                    sh "docker push ${env.DOCKER_USER_NAME}/student-management:latest"
                    
                    echo "Déconnexion de Docker Hub"
                    sh "docker logout"
                }
            }
        }
    }
}
