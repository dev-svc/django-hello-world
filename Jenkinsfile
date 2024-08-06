pipeline {
   agent {
    kubernetes {
        cloud 'kubernetes'
        label 'python-template'
      }
   }
   
   environment {
       VIRTUAL_ENV = "${env.WORKSPACE}/env"
   }
   stages {
    stage("Local Install"){
        steps {
            container('python'){
                
                sh """
               
                python3 -m venv ${env.VIRTUAL_ENV}
                ls -ltr
                . ${env.VIRTUAL_ENV}/bin/activate
                pip install --upgrade pip setuptools wheel
                pip install build
                pip install -r ./requirements.txt
                """
            }
        }
    }
    stage("Test") {
        steps {
            container('python'){
                sh """
                . ${env.VIRTUAL_ENV}/bin/activate 
                coverage run -m pytest 
                """
            }
        }
    }
    stage("Code Coverage") {
        steps {
            container('python'){
                sh """
                . ${env.VIRTUAL_ENV}/bin/activate 
                 
                  coverage report -m
                  coverage xml
                """
            }
        }
    }
    stage("Code Analysis") {
        steps {
            container('python'){
                withSonarQubeEnv("sonarcloudScanner"){
                sh """
             
                wget "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.1.0.4477-linux-x64.zip"
                ls -ltr
                unzip sonar-scanner-cli-6.1.0.4477-linux-x64.zip -d /opt
                ls -ltr /opt/sonar-scanner-6.1.0.4477-linux-x64
            
                export PATH=$PATH:/opt/sonar-scanner-6.1.0.4477-linux-x64/bin/
                sonar-scanner -Dsonar.organization=devsvc -Dsonar.projectKey=django-hello-world -Dsonar.python.coverage.reportPaths=coverage.xml
                """
                }
            }
        }
    }
    
   stage("Docker Build"){
        steps{
            container('docker') {
               sh "docker build -t rajeshd2090/django-hello-world:1.0 ."
            }
        }
    }
}
}
