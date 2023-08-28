                sh "sudo docker build -t your-registry/edureka-cicd:${VERSION} ."

                // Deploy Docker container with the unique tag
                cd /var/lib/jenkins/workspace/edureka-cicd-project-2
                sh "sudo docker run -d -p 8081:8081 your-registry/edureka-cicd:${VERSION}"
