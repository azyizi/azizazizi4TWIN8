// Jenkinsfile
pipeline {
    // Exécute le pipeline sur n'importe quel agent disponible (votre VM)
    agent any

   
       
    }

    stages {
        stage('Build and Test') {
            steps {
                echo 'Démarrage du build Maven et exécution des tests unitaires...'
                // La commande 'mvn clean install' clone, compile, exécute les tests,
                // et package le projet (génère le JAR/WAR).
                sh 'mvn clean install'
            }
        }
        
        // Vous pouvez ajouter une étape de déploiement ici (facultatif)
        stage('Package Information') {
            steps {
                echo 'Build terminé avec succès.'
                // Affiche des informations pour confirmation
                sh 'ls -l target/'
            }
        }
    }
}
