pipeline {
    agent {label 'master'}
    environment {
        SVC_ACCOUNT_KEY = credentials('terraform-gcp-auth')
    }

    stages{
        stage('Checkout'){
            steps{
                checkout scm
                sh 'mkdir -p creds'
                sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./creds/serviceaccount.json'
            }
        }

        stage('TF Plan'){
            steps{
                sh '/app/terraform_0.12/terraform init'
                sh '/app/terraform_0.12/terraform plan -out=tfplan'
            }
        }
    }
}
