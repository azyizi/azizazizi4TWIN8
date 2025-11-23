pipeline {

 agent any

 

    stages {
        stage('Build and Test') {
            steps {
                echo 'Démarrage du build Maven et exécution des tests unitaires...'
                // La commande 'mvn clean install' gère la compilation, les tests et le packaging.
                sh 'mvn clean install'
            }
        }
        
        stage('Package Information') {
            steps {
                echo 'Build terminé avec succès. Vérification des artefacts...'
                // Affiche les fichiers générés dans le répertoire target
                sh 'ls -l target/'
            }
        }
    }
}
