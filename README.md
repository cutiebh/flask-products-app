# Products App designed using Python flask.
# Terraform is used to create an AWS EC2 instance.
# CI/CD pipeline is implemented using GitHub Actions.

# A basic,minimal application using:
# This project demonstrates a complete DevOps workflow from source code → automated tests → automated deployment to AWS.

The project uses :
-   Terraform (Infrastructure as Code)
-   GitHub Actions (CI/CD pipeline)
-   Gunicorn + systemd (Linux service)
-   Python virtual environment
-   Flake8 linting
-   Pytest unit & integration tests


# Application
- Simple Flask web app with:
  - HTML Home Page (`/`)
  - JSON API endpoint (`/api/info`)

# DevOps / Automation
- Fully automated CI/CD pipeline
- Linting with **flake8**
- **Unit tests** and **integration tests** using pytest
- Automatic deployment to EC2 on pushes to `main`
- Deployment logs visible in GitHub Actions

# Infrastructure
- EC2 instance provisioned using Terraform
- Security Group for SSH + port 8000
- Gunicorn configured via systemd running inside a Python `venv`
- User-data script sets up the environment on first boot

# Procedure to run the application:
1. Clone the githib repo.
2. In GitHub Actions Setup
    Create the following Repository secrets and set the below values:
    EC2_HOST	<Refer step 3>
    EC2_USER	ubuntu
    EC2_PATH	/var/www/flaskapp
    EC2_KEY	    Copy entire contents of .pem file. Note than key value pairs are region-specific.

3. Open the Terminal and run the below commands:
    cd terraform
    terraform init
    terraform plan
    terraform apply
    Copy the ec2_public_ip in the Outputs section in the logs to the repo secret EC2_HOST

4. The CI/CD workflow is in .github/workflows/deploy.yml

5. Open README.md and make some changes and save.
6. Stage and commit these changes to local repo.
7. Push the change to main branch on the remote repo. 
This push event will trigger the pipeline to build, test and deploy the project on the EC2 instance created in step 3.

8. Check the logs in GitHub actions.
After deployment, GitHub Actions prints:

7. After all jobs pass, below message should be displayed.
Deployment successful!

8. Launch the app in the browser.
http://<EC2-HOST>:8000/




