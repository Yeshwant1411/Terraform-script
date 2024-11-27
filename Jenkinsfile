pipeline {
    agent { label 'Terraform-Agent' }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the GitHub repo
                git branch: 'main', url: 'https://github.com/Yeshwant1411/Terraform-script.git'
            }
        }
        stage('Terraform Init') {
            steps {
                // Initialize Terraform
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                // Run Terraform plan to check for any changes
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                // Apply the Terraform changes
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
