# Introduction
This project is using Terraform to deploy AWS EKS service

## Step
1. All variables is store in "Devlopment" or "Production" and under "Environments" folder. Please modify the variables in variables.tf file if you need.
2. Create a tag and the format must be "dev-0.0.1" or "pro-0.0.1"
3. After create the tag, it will trigger pipeline to deploy to AWS
4. You may need to manual cick the deploy button on the pipeline.
