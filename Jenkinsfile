pipeline {
    agent any
    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred')
	}

    stages {
        
        stage('clone src') {
            steps {
                git branch: 'master', url: 'https://github.com/hackcoderr/nginx.git'
            }
        }
        stage('build docker image') {
            steps {
                sh 'docker build -t react-simple-app .'
                sh 'docker tag react-simple-app vaibhav099/react-simple-app:latest'
            }
        }
        stage('push docker image') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push vaibhav099/react-simple-app:latest'
            }
       }
       stage('deploy app') {
            steps {
		sshPublisher(publishers: [sshPublisherDesc(configName: 'react-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'docker rm -f react-app', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])    
                sshPublisher(publishers: [sshPublisherDesc(configName: 'react-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'docker run -dit --name react-app -p 3000:3000 vaibhav099/react-simple-app', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
       }
    }
}
