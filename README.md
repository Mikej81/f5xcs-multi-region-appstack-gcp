# f5xcs-multi-region-appstack-gcp

This is a non-official F5 repository.  This repo is not supported by F5 or DevCentral!

This repo will provide a solution for deploying F5 XCS Multi-Region Multi-Zone AppStack in GCP.

# Distributed Cloud GCP Multi-Region Multi-Zone AppStack

The goal of this solution is to provide the infrastructure for a working demo to deploy F5 Distributed Cloud AppStack and Virtual Kubernetes (vk8s) on GCP in multiple regions with multiple zones.
<!--TOC-->

- [F5 Distributed Cloud GCP AppStack Multi-Region and Multi-Zone Deployment](#f5-distribued-cloud-gcp-appstack-multi-region-and-multi-zone-deployment)
  - [To do](#to-do)
  - [Requirements](#requirements)
  - [Modules](#modules)
  - [Deployment](#deployment)

<!--TOC-->

## To do

- Optional step (if you plan to run Managed or Physical k8s):
    - Add cluster role with proper policy rules.
        - Create a tfvars file or override.tf
        - URL List
            - URLs:*
            - Allowed Verbs:*
        - Resource List
            - API Groups:*
            - Resource Types:*
            - Allowed Verbs:*
        - Resource List
            - API Groups:rbac.authorization.k8s.io
            - Resource Types:rolebindings, clusterroles, clusterrolebindings
            - Resource Instances:admin, edit, view
            - Allowed Verbs:create, bind, escalate
    - Add Cluster Role Bidning for user.  Select ves-io-admin-cluster-role.
        - Subject - email of user account
- Infrastructure buildout in GCP
    - Run example_prep.sh
    - Export variables:
        - export VOLT_API_P12_FILE=/creds/.api-creds.p12
        - export VES_P12_PASSWORD=12345678
        - export GCP_PROJECT=project_name
        - export GCP_ROLE_ID=xcs_gcp_vpc_role
        - export GCP_ACCOUNT_ID=xcs-gcp-vpc-spn
    - Validate GCP Role ID and Account ID were created in proper project
    - Manully or Auto Deploy (see [Deployment](#deployment) options below):

![Rough Diagram](/images/gcp-appstack.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.15.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 2.1.1 |
| <a name="requirement_volterrarm"></a> [volterrarm](#requirement\_volterrarm) | 0.11.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_util"></a> [util](#module\_util) | ./util | n/a |
| <a name="module_gcp"></a> [gcp](#module\_gcp) | ./gcp | n/a |
| <a name="module_xcs"></a> [xcs](#module\_xcs) | ./xcs | n/a |

## Deployment

For manual deployment you can do the traditional terraform commands.

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

For auto deployment you can do with the deploy.sh and destroy.sh scripts.

```bash
./deploy
./destroy
```
