def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]

pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                echo 'clone project code'
                git branch: 'main', url: 'https://github.com/amoppskay/kay-ventures.git'
                sh 'ls'
            }
        }
        
        stage('Verify Terraform Version'){
            steps{
                echo 'verifying Terraform version...'
                sh 'terraform --version'
            }
        }
        
         stage('Terraform Initialize'){
            steps{
                echo 'initializing Terraform...'
                sh 'terraform init'
            }
        }
        
        stage('Terraform Validate'){
            steps{
                echo 'checking for code syntax...'
                sh 'terraform validate'
            }
        }
        
         stage('Terraform Plan'){
            steps{
                echo 'Terraform Plan for dry code dry run...'
                sh 'terraform plan'
            }
        }
        
        stage('Checkov Scan'){
            steps{
                sh """
                sudo pip3 install checkov
                checkov -d . --skip-check CKV_AWS_79
                """
            }
        }
        
        stage('Manual Approval'){
            steps{
               input 'Approval required for deployment'
            }
        }
        
        stage('Terraform Apply'){
            steps{
                echo 'Terraform Apply...'
                sh 'sudo terraform apply -auto-approve'
            }
        }
        
    }
    
    
    post { 
        always { 
            echo 'I will always say Hello again!'
            slackSend channel: '#glorious-w-f-devops-alerts', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"

        }
    }
}
