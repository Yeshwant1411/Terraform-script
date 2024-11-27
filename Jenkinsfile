pipeline {
    agent { label 'Terraform-Agent' }

    environment {
        AWS_REGION = 'ap-south-1'
        TF_VAR_profile = 'default'  // AWS CLI profile for authentication
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from your repository
                checkout scm
            }
        }

        stage('Setup AWS Credentials') {
            steps {
                // Configure AWS credentials
                withCredentials([string(credentialsId: 'aws-access-key-ID', variable: 'AWS_ACCESS_KEY_ID'),
                                 string(credentialsId: 'aws-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    script {
                        sh 'aws sts get-caller-identity'
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform working directory
                    sh 'terraform init -backend-config="bucket=my-terraform-backend" -backend-config="key=terraform.tfstate" -backend-config="region=${AWS_REGION}"'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                script {
                    // Validate Terraform configuration
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Generate Terraform plan
                    sh 'terraform plan -var="region=${AWS_REGION}" -var="profile=${TF_VAR_profile}"'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply Terraform configuration to create/update resources
                    sh 'terraform apply -auto-approve -var="region=${AWS_REGION}" -var="profile=${TF_VAR_profile}"'
                }
            }
        }

        stage('Output ALB DNS Name') {
            steps {
                script {
                    // Output the DNS name of the ALB
                    def alb_dns = sh(script: 'terraform output -raw alb_dns_name', returnStdout: true).trim()
                    echo "ALB DNS Name: ${alb_dns}"
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform Deployment Successful!'
        }
        failure {
            echo 'Terraform Deployment Failed!'
        }
    }
}
