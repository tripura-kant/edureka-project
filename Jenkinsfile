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
        stage("Install Tools and Dependencies") {
            steps {
                script {
                    // Cloning Git repository
                    checkout([$class: 'GitSCM', 
                              branches: [[name: 'main']], 
                              doGenerateSubmoduleConfigurations: false, 
                              extensions: [], 
                              userRemoteConfigs: [[url: 'https://github.com/tripura-kant/edureka-project.git']]])

                    currentBuild.description = "This build is used for CICD"
                    currentBuild.displayName = "Edureka CICD"
                }
                sh """
                pip3 install python-jenkins==1.8.0
                pip3 install urllib3==1.26.12
                pip3 install boto3
                """
                dir("$env.WORKSPACE") {
                    sh """
                    cd /var/lib/jenkins/workspace/edureka-cicd-project-2
                    sh -x install-script.sh
                    """
                }
            }
        }
    }
}
