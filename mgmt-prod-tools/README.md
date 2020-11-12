# Infrastructure as Code: This document explains what the management repository is needed for (mgmt-prod-tools)

<!--

Check list for every README:
- Verify the requirement are the same, make sure the required plugins are there
- Modify the Project Requirements section. It should be different for every project
- Modify the Project Validation section. It should be different for every project

-->

This directory contains terraform code to create a management VPC to access a bastion host vm for managing the OpenShift cluster (OCP).

In order to access the mgmt-prod-tools VPC you'll need to install several components.

  - [General Requirements](#general-requirements)
  - [The management production tools VPC](#The-management-production-tools-VPC)


## General Requirements

Same for every pattern, the requirements are documented in the [Environment Setup](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment). It includes:

- Create an IBM Cloud User Account
- Create separate IBM Cloud accounts for development and production
- Install Visual Studio’s and download the mgmt-prod-tools module
- Use the IBM Cloud user account to access IBM Cloud Schematics

## The management production tools VPC 

- Download this repo and make the appropriate changes for your environemnt. Use IBM Cloud Schematics along with Terrform to create the VPC. 
- Once the VPC has been created you'll need to setup a VSI image (bastion host) with a private & public key pair
- Use OpenVPN to create the VPN gateway between the on-premises location to access the VSI or bastion host
- Make sure to configure your security group (SG) rules for inbound and outbound access for only the necessary services & protocols
- consider not using access control list (ACL), SG's are considered more robust in access restrictions
- There is documentation included in this repo on how to create the OpenVPN connection to the bastion host
- This repo includes Terraform (TF) code for creating a Transit Gateway (TG) located in the fs-cloud-prod-vpc repo under the network.tf file
- Configure the TG connections for the mgmt-prod-tools VPC & front-offic-prod-vpc. 
- The front-office-prod-vpc, TF code is located in the fs-cloud-prod-vpc repository
- Once the VPN has been established, log into the bastion host and setup the necessary tools for accessing the OCP
- The bastion host can also be used to configure any CICD pipelines or other necessary administrative duties for managing the production environment
- Keep in mind, the TG is used for allowing the bastion host to access the OCP and the VPN connectivity allows the on-premise or remote enterprise administrator to manage the bastion host and OCP cluster