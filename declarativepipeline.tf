   
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



