# Infrastructure as Code: Creating Red Hat OpenShift clusters on VPC

<!--

Check list for every README:
- Verify the requirement are the same, make sure the required plugins are there
- Modify the Project Requirements section. It should be different for every project
- Modify the Project Validation section. It should be different for every project

-->

This directory contains terraform code to create a minimum Red Hat OpenShift cluster in a VPC. 


- [Infrastructure as Code: Creating Red Hat OpenShift clusters on VPC Gen2](#infrastructure-as-code-creating-red-hat-openshift-clusters-on-vpc-gen2)
  - [General Requirements](#General-requirements)
  - [Using Visual Studio Code](#Using-Visual-Studio-Code)
  - [How to use with Terraform](#How-to-use-IBM-Cloud-Schematics)


## General Requirements

Same for every pattern, the requirements are documented in the [Environment Setup](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment). It includes:

- Create an IBM Cloud User Account
- Create separate IBM Cloud accounts for development and production
- Create and name a single GitHub repository (repo) for your Terraform (TS) project
- Create a local workspace on your computer for the Github repository
- Install Visual Studio’s to configure your TF modules
- Use the IBM Cloud user account to access IBM Cloud Schematics

## Using Visual Studio Code

- Create a public Github repository for the below work
- Launch Visual Studio Code (VSC) and launch a new VSC terminal
- In the VSC terminal type “pwd” 
- Cd down into “github”
- Type in mkdir “fss-cloud”
- Cd down to fss-cloud
- Open up VSC, then clone the fss-cloud-automation repo into the working directory fss-cloud
- Setup your push & pull Github account in VSC
- Make the necessary changes to the TF modules, and any other files
- 11.	Commit the changes and push to GitHub 

## How to use IBM Cloud Schematics

- Log into IBM Cloud and access Schematics
- Switch to the IBM Cloud account where you wish to create Schematics Workspace
- In Schematics, create your Workspace
- Name the Workspace, add a tag, select your resource group (if you haven’t, create one or use the default)
- Select your region and add in the description for the Schematics Workspace and then choose Create
- Add in your fss-cloud, Terraform, Github repository in the Schematics URL section
- Select Terraform version _v0.12 and Save template information
- For the Variables section, add any custom variables to override the TF modules and click Save Changes
- In Schematics, click on Generate plan at the top. If the plan is successful you can click on Apply Plan
- If the Schematics Apply plan was unsuccessful, review the logs to fix the issues
- In IBM Cloud, choose the hamburger menu and choose Resource List, to review your deployments
