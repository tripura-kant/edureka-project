pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        timestamps()
    }

    stages {
        stage('Init') {
            steps {
                echo "hello"
            }
        }
        stage("check if all dependencies installed") {
            steps {
                script {
                    gitClone("https://github.com/tripura-kant/edureka-project.git", "edureka-project", "main")
                    currentBuild.description = "This build is used for CICD"
                    currentBuild.displayName = "Edureka CICD"
                }
                sh """
                pip3 install python-jenkins==1.8.0
                pip3 install urllib3==1.26.12
                pip3 install boto3
                """
                dir("$env.WORKSPACE/edureka-project") {
                    sh """
                    sh install-script.sh
                    """
                }
            }
        }
    }
}