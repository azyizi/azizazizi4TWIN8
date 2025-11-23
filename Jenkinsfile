pipeline {

 agent any

 

 stages {

 stage('GIT') {

           steps {

               git branch: 'main',

               url: ' https://github.com/azyizi/azizazizi4TWIN8'

          }

     }

 stage ('Compile Stage') {

 steps {

 sh 'mvn clean compile'

 }

 }
