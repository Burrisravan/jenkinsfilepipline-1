   
pipeline {
    agent any

    stages {
        stage("Build") {
            steps {
                echo "Some code compilation here..."
            }
        }

        stage("Test") {
            steps {
                echo "Some tests execution here..."
                echo "1"
            }
        }

        stage("Deploy") {
            steps {
                echo "Some tests execution here..."
                echo "1"
            }
        }
    }
}

###########################2nd timestamp or when statement #####################################

pipeline {
    agent any

    options {
        timestamps()
    }

    stages {
        stage("Build") {
            options {
                timeout(time: 1, unit: "MINUTES")
            }
            steps {
                sh 'printf "\\e[31mSome code compilation here...\\e[0m\\n"'
            }
        }

        stage("Test") {
            when {
                environment name: "ENVT", value: "TEST"
            }
            options {
                timeout(time: 2, unit: "MINUTES")
            }
            steps {
                echo "This Is An Test Environment"
            }
        }

        stage("Dev") {
            when {
                environment name: "ENVT", value: "DEV"
            }
            options {
                timeout(time: 2, unit: "MINUTES")
            }
            steps {
                echo "This Is An Dev Environment"
            }
        }

        stage("Prod") {
            when {
                environment name: "ENVT", value: "PROD"
            }
            options {
                timeout(time: 2, unit: "MINUTES")
            }
            steps {
                echo "This Is An Prod Environment"
            }
        }
    }
}


#################################################################################################################################
pipeline {
    agent any
    stages {
		    stage('Packer Build AMI') {
          steps {
            
            sh 'pwd'
            sh 'ls -al'
            sh 'packer build packer.json'
            }
        }
				
	      stage('Deploy EC2 Server') {
          steps {
		      sh 'terraform init'
            sh 'terraform plan'
            sh 'terraform apply --auto-approve'
            }
        }

        stage('Build Docker Image') {
          steps {
            sh 'docker build -t sreeharshav/devopsb15:${BUILD_NUMBER} .'
            }
        }

        stage('Push Image to Docker Hub') {
          steps {
           sh    'docker push sreeharshav/devopsb15:${BUILD_NUMBER}'
           }
        }

        stage('Deploy to Docker Host') {
          steps {
		    sh 'sleep 30s'
            sh    'docker -H tcp://10.1.1.111:2375 stop prodwebapp1 || true'
            sh    'docker -H tcp://10.1.1.111:2375 run --rm -dit --name prodwebapp1 --hostname prodwebapp1 -p 8000:80 sreeharshav/devopsb15:${BUILD_NUMBER}'
            }
        }

        stage('Check WebApp Rechability') {
          steps {
          sh 'sleep 10s'
          sh ' curl http://10.1.1.111:8000'
          }
        }

    }
}


