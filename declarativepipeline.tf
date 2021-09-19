   
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



###########################2nd level#####################################

