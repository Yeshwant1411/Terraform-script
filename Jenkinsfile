pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        TF_VAR_profile = 'default'  // Use the AWS CLI profile (ensure it's configured in Jenkins)
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the Terraform code from the repository
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform working directory
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform configuration to provision the infrastructure
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Output ALB DNS Name') {
            steps {
                script {
                    // Get the DNS name of the Application Load Balancer (ALB)
                    def alb_dns = sh(script: 'terraform output -raw alb_dns_name', returnStdout: true).trim()
                    echo "ALB DNS Name: ${alb_dns}"
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform deployment successful!'
        }
        failure {
            echo 'Terraform deployment failed!'
        }
    }
}
