pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                 script {
                    sh "docker run --rm -t -u \$(id -u):\$(id -g) -e NWN_HOME=\$(pwd) -v \$(pwd):\$(pwd) -v \$(pwd):/nasher cltalmadge/nasher:1.1.1 pack --clean --verbose --yes"
                }
            }
        }
        stage('Deploy Test') {
            when {
                expression {
                    return params.ENVIRONMENT == 'Test'
                }
            }
            steps {
                echo 'Deploying....'
                sh 'sudo cp Amia.mod /home/amia/amia_server/test_server/modules;'
                sh 'chmod +x deploy-test.sh'
                sh './deploy-test.sh'
            }
        }
        stage('Deploy Live') {
            when {
                expression {
                    return params.ENVIRONMENT == 'Live'
                }
            }
            steps {
                sh 'sudo cp Amia.mod /home/amia/amia_server/server/modules;'
                sh 'chmod +x deploy-live.sh'
                sh './deploy-live.sh'
            }
        }
    }
    post {
        always {
             discordSend description: "Builder for Amia module finished.", footer: "Build results for Amia module", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: params.webhookURL
        }
        success {
            echo 'Build success'
            archiveArtifacts artifacts: 'Amia.mod', followSymlinks: false
            sh "sudo rm -rf Amia.mod"
        }
    }
}