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
        
        stage('Approval') {
            steps {
                script {
                    def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
                    }
            }
        }

        stage('TF Apply') {
            steps {
                sh '/app/terraform_0.12/terraform apply -input=false tfplan'
            }
        }
        
        environment{
            KUBEMASTERIP = "${sh(script:'terraform output kubemaster_public_ip')}"
        }
        
        stage('Get IP addresses'){
            steps{
                echo "${env.KUBEMASTERIP}"
            }
        }
    }
}
