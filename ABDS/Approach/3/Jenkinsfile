pipeline {
    agent any
 
 
    stages {
        stage('Build') {
            steps {
                echo '> Checking out the Git version control ...'
                checkout scm
            }
        }
	stage('Test') {
            steps {
                echo '> Using ansible-lint'
		sh 'apt install python3'
                sh 'pip3 install "ansible-lint[yamllint]"'
		sh 'ansible-lint'
                
            }
        }
        stage('Deploy') {
            steps {
                echo '> Deploying the application ...'
                ansiblePlaybook(
                    inventory: 'inventory.ini',
                    playbook: 'site.yml'
                )
            }
        }
    }
}
