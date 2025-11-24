// Jenkinsfile (AVEC LA CORRECTION DOCKER_BUILDKIT)
pipeline {
    agent any
    
    environment {
        DOCKER_USER_NAME = 'azizi02k' // Votre Nom d'utilisateur Docker Hub
    }

    tools {
        jdk 'JAVA-HOME' 
        maven 'M2 HOME' 
    }

    stages {
        // ... (Clean and Build inchangé) ...

        stage('Build Docker Image') {
            steps {
                // AJOUT DE withEnv(['DOCKER_BUILDKIT=0']) POUR RÉSOUDRE L'ERREUR "not found"
                withEnv(['DOCKER_BUILDKIT=0']) { 
                    echo "Construction de l'image Docker: ${env.DOCKER_USER_NAME}/student-management:latest"
                    sh "docker build -t ${env.DOCKER_USER_NAME}/student-management:latest ." 
                }
            }
        }
        
        stage('Push Docker Image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    echo "Connexion à Docker Hub..."
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
