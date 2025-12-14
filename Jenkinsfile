// Jenkinsfile COMPLET
pipeline {
    agent any
    
    // Variables du Pipeline
    environment {
        // NOTE: Utiliser BUILD_NUMBER pour un tag unique à chaque exécution
        DOCKER_USER_NAME = 'azizi02k'
        DOCKER_IMAGE_REPO = "${DOCKER_USER_NAME}/student-management"
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // ID des credentials dans Jenkins
        
        KUBERNETES_NAMESPACE = 'devops'
        APP_DEPLOYMENT = 'springboot-app'
    }

    tools {
        // Ces noms doivent correspondre EXACTEMENT aux noms configurés dans Jenkins
        jdk 'JAVA-HOME'
        maven 'M2 HOME'
    }

    stages {
        stage('Clean and Build (Maven)') {
            steps {
                echo '1. Construction du projet avec Maven.'
                sh "mvn clean package -DskipTests" 
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    def imageTag = "${env.DOCKER_IMAGE_REPO}:${env.BUILD_NUMBER}"
                    echo "2. Construction de l'image Docker: ${imageTag}"
                    
                    // Correction pour l'environnement Minikube/Vagrant
                    withEnv(['DOCKER_BUILDKIT=0']) { 
                        sh "docker build -t ${imageTag} ." 
                    }
                }
            }
        }
        
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    def imageTag = "${env.DOCKER_IMAGE_REPO}:${env.BUILD_NUMBER}"
                    
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        echo "3. Connexion à Docker Hub et Push de l'image ${imageTag}..."
                        // Connexion sécurisée
                        sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                        sh "docker push ${imageTag}"
                        sh "docker logout"
                    }
                }
            }
        }
        
        // ÉTAPE CRUCIALE POUR L'ATELIER : LE DÉPLOIEMENT SUR KUBERNETES
        stage('Kubernetes Deployment (Rolling Update)') {
            steps {
                echo '4. Déploiement de la nouvelle image sur Kubernetes via Rolling Update...'
                def newImage = "${env.DOCKER_IMAGE_REPO}:${env.BUILD_NUMBER}"
                
                // Met à jour l'image du conteneur 'spring-app' dans le déploiement 'springboot-app'
                sh "kubectl set image deployment/${APP_DEPLOYMENT} spring-app=${newImage} -n ${KUBERNETES_NAMESPACE}"
                
                // Attend que le Rolling Update soit terminé et stable
                sh "kubectl rollout status deployment/${APP_DEPLOYMENT} -n ${KUBERNETES_NAMESPACE} --timeout=5m"
            }
        }
    }
    
    post {
        always {
            echo "Pipeline terminé. Statut: ${currentBuild.result}"
        }
    }
}
