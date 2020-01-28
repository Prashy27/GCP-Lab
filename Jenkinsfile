node {
    withEnv(['SVC_ACCOUNT_KEY = credentials('terraform-gcp-auth')']){
        stage('Checkout'){
            steps{
                checkout scm
                sh 'mkdir -p creds'
                sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./creds/serviceaccount.json'
            }
        }
    }
}
