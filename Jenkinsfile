pipeline {
    agent {
        docker { 
            image "adrianobma/robotwd" 
            args "--network=skynet"
        }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Baixando as depedências do projeto'
                sh 'pip install -r backend/requirements.txt'
            } 
        }
        stage('Tests') {
            steps {
                echo 'Executando testes de regressão'
                sh 'robot -d ./log -v browser:headless tests/'
            }
            post {
                always {
                    robot otherFiles: '**/*.png', outputPath: 'log'
                }
            }
        }
        stage('UAT') {
            steps {
                echo 'Aprovação dos testes de aceitação' 
                input(message: 'Podemos ir para produção?', ok: 'Proseguir')
            } 
        }
        stage('Production') {
            steps {
                echo 'WebApp Ok em produção!'
            } 
        }
    }
}