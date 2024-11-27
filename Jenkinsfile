pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-credentials-jenkins')   // Reference your AWS credentials
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials-jenkins')
        TERRAFORM_VERSION = '1.9.8' // Specify Terraform version you want to use
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Yeshwant1411/Terraform-script.git' // Replace with your GitHub repo URL
            }
        }

        stage('Install Terraform') {
            steps {
                script {
                    // Install Terraform if not installed
                    sh '''
                    if ! terraform version; then
                      wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                      unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                      mv terraform /usr/local/bin/
                    fi
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'  // Initialize the Terraform working directory
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'  // Run Terraform plan
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve tfplan'  // Apply the Terraform changes
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // Clean workspace after the build
        }
    }
}
