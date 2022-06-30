# f5xcs-multi-region-appstack-gcp

This is a non-official F5 repository.  This repo is not supported by F5 or DevCentral!

This repo will provide a solution for deploying F5 XCS Multi-Region Multi-Zone AppStack in GCP.

# Distributed Cloud GCP Multi-Region Multi-Zone AppStack

The goal of this solution is to provide the infrastructure for a working demo to deploy F5 Distributed Cloud AppStack and Virtual Kubernetes (vk8s) on GCP in multiple regions with multiple zones.
<!--TOC-->

- [F5 Distributed Cloud GCP AppStack Multi-Region and Multi-Zone Deployment](#f5-distribued-cloud-gcp-appstack-multi-region-and-multi-zone-deployment)
  - [To do](#to-do)
  - [High Level Topology](#topology)
  - [Requirements](#requirements)
  - [Modules](#modules)
  - [Deployment](#deployment)
  - [Troubleshooting](#troubleshooting)
  - [Support](#support)
  - [Community Code of Conduct](#community-code-of-conduct)
  - [License](#license)
  - [Copyright](#copyright)
  - [F5 Networks Contributor License Agreement](#f5-networks-contributor-license-agreement)

<!--TOC-->

## To do

- Optional step (if you plan to run Managed or Physical k8s):
    - Add cluster role with proper policy rules.
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
    - Create a tfvars file or override.tf
    - Manully or Auto Deploy (see [Deployment](#deployment) options below):

## Topology
- High Level Topology 

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

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| <a name="project_name"></a> [projectname](#inputs\_project\_name) | REQUIRED:  This is your GCP Project Name | `string` | `"gcp_project_name"` |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | REQUIRED:  This is your Volterra Tenant Name:  https://<tenant\_name>.console.ves.volterra.io/api | `string` | `"f5-xc-lab-app"` |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | REQUIRED:  This is your Volterra Namespace | `string` | `"app1-dev"` |
| <a name="input_api_cert"></a> [api\_cert](#input\_api\_cert) | REQUIRED:  This is the path to the Volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials | `string` | `"./creds/api2.cer"` |
| <a name="name"></a> [name](#inputs\_name) | REQUIRED:  This is your Distributed Cloud prefix name | `string` | `"cust-provided"` |
| <a name="stack_name"></a> [stackname](#inputs\_stack\_name) | REQUIRED:  This is your Distributed Cloud AppStack name | `string` | `"gcp-app-stack"` |
| <a name="gcp_region_one"></a> [gcp_region_one](#inputs\_gcp\_region\_one) | REQUIRED:  This is your GCP Region One | `string` | `"us-east4"` |
| <a name="gcp_region_one_zone_a"></a> [gcp_region_one_zone_a](#inputs\_gcp\_region\_one\_zone\_a) | REQUIRED:  This is your GCP Region One Zone A| `string` | `"us-east4a"` |
| <a name="gcp_region_one_zone_b"></a> [gcp_region_one_zone_b](#inputs\_gcp\_region\_one\_zone\_b) | REQUIRED:  This is your GCP Region One Zone B| `string` | `"us-east4b"` |
| <a name="gcp_region_one_zone_c"></a> [gcp_region_one_zone_c](#inputs\_gcp\_region\_one\_zone\_c) | REQUIRED:  This is your GCP Region One Zone C| `string` | `"us-east4c"` |
| <a name="gcp_cidr_one"></a> [gcp_cidr_one](#inputs\_gcp\_cidr\_one) | REQUIRED:  This is your GCP Region One cidr| `string` | `"10.90.0.0/23"` |
| <a name="gcp_subnet_one"></a> [gcp_subnet_one](#inputs\_gcp\_subnet\_one) | REQUIRED:  This is your GCP Region One subnet| `string` | `"10.90.0.0/24"` |
| <a name="gcp_region_two"></a> [gcp_region_two](#inputs\_gcp\_region\_two) | REQUIRED:  This is your GCP Region One | `string` | `"us-west2"` |
| <a name="gcp_region_one_zone_a"></a> [gcp_region_two_zone_a](#inputs\_gcp\_region\_two\_zone\_a) | REQUIRED:  This is your GCP Region Two Zone A| `string` | `"us-west2a"` |
| <a name="gcp_region_one_zone_b"></a> [gcp_region_two_zone_b](#inputs\_gcp\_region\_two\_zone\_b) | REQUIRED:  This is your GCP Region Two Zone B| `string` | `"us-west2b"` |
| <a name="gcp_region_one_zone_c"></a> [gcp_region_two_zone_c](#inputs\_gcp\_region\_two\_zone\_c) | REQUIRED:  This is your GCP Region Two Zone C| `string` | `"us-west2c"` |
| <a name="gcp_cidr_two"></a> [gcp_cidr_two](#inputs\_gcp\_cidr\_two) | REQUIRED:  This is your GCP Region two cidr| `string` | `"10.90.2.0/23"` |
| <a name="gcp_subnet_two"></a> [gcp_subnet_two](#inputs\_gcp\_subnet\_two) | REQUIRED:  This is your GCP Region two subnet| `string` | `"10.90.2.0/24"` |
| <a name="gcp_region_three"></a> [gcp_region_three](#inputs\_gcp\_region\_three) | REQUIRED:  This is your GCP Region One | `string` | `"europe-west3"` |
| <a name="gcp_region_three_zone_a"></a> [gcp_region_three_zone_a](#inputs\_gcp\_region\_three\_zone\_a) | REQUIRED:  This is your GCP Region Three Zone A| `string` | `"us-europe-west3a"` |
| <a name="gcp_region_three_zone_b"></a> [gcp_region_three_zone_b](#inputs\_gcp\_region\_three\_zone\_b) | REQUIRED:  This is your GCP Region Three Zone B| `string` | `"us-europe-west3b"` |
| <a name="gcp_region_three_zone_c"></a> [gcp_region_three_zone_c](#inputs\_gcp\_region\_three\_zone\_c) | REQUIRED:  This is your GCP Region Three Zone C| `string` | `"us-europe-west3c"` |
| <a name="gcp_cidr_three"></a> [gcp_cidr_three](#inputs\_gcp\_cidr\_three) | REQUIRED:  This is your GCP Region Three cidr| `string` | `"10.90.4.0/23"` |
| <a name="gcp_subnet_three"></a> [gcp_subnet_three](#inputs\_gcp\_subnet\_three) | REQUIRED:  This is your GCP Region three subnet| `string` | `"10.90.4.0/24"` |
| <a name="gcp_instance_type"></a> [gcp_instance_type](#inputs\_gcp\_instance\_type) | REQUIRED:  This is your GCP Instance Type | `string` | `"n1-stnadard-4"` |
| <a name="input_sshPublicKey"></a> [sshPublicKey](#input\_sshPublicKey) | OPTIONAL: ssh public key for instances | `string` | `""` |
| <a name="input_api_p12_file"></a> [api\_p12\_file](#input\_api\_p12\_file) | REQUIRED:  This is the path to the Volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials | `string` | `"./creds/f5-xc-lab-app.console.ves.volterra.io.api-creds.p12"` |
| <a name="input_sshPublicKeyPath"></a> [sshPublicKeyPath](#input\_sshPublicKeyPath) | OPTIONAL: ssh public key path for instances | `string` | `"./creds/id_rsa.pub"` |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | REQUIRED:  This is the path to the Volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials | `string` | `"./creds/api.key"` |
| <a name="input_delegated_dns_domain"></a> [delegated\_dns\_domain](#input\_delegated\_dns\_domain) | n/a | `string` | `"user-defined"` |
| <a name="input_volterra_tf_action"></a> [volterra\_tf\_action](#input\_volterra\_tf\_action) | n/a | `string` | `"apply"` |
| <a name="input_gateway_type"></a> [gateway\_type](#input\_gateway\_type) | n/a | `string` | `"voltstack_cluster"` |
| <a name="api_url"></a> [api\_url](#input\_api\_url) | n/a | `string` | `"https://f5-xc-lab-app.console.ves.volterra.io/api"` |
<a name="input_tags"></a> [tags](#input\_tags) | Environment tags for objects | `map(string)` | <pre>{<br>  "application": "f5app",<br>  "costcenter": "f5costcenter",<br>  "creator": "Terraform",<br>  "delete": "True",<br>  "environment": "gcp",<br>  "group": "f5group",<br>  "owner": "f5owner",<br>  "purpose": "public"<br>}</pre> | 

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

## Troubleshooting

Please refer to the following: 
- F5 Distributed Cloud
    - [F5 Distributed Cloud](https://docs.cloud.f5.com/docs/)
- Terraform
    - [F5 Distributed Cloud Terraform Registry](https://registry.terraform.io/providers/volterraedge/volterra/latest/docs).

## Support

For support, please open a GitHub issue.  Note, the code in this repository is community supported and is not supported by F5 Networks.  For a complete list of supported projects please reference [SUPPORT.md](SUPPORT.md).

## Community Code of Conduct

Please refer to the [F5 DevCentral Community Code of Conduct](code_of_conduct.md).

## License

[Apache License 2.0](LICENSE)

## Copyright

Copyright 2014-2022 F5 Networks Inc.

### F5 Networks Contributor License Agreement

Before you start contributing to any project sponsored by F5 Networks, Inc. (F5) on GitHub, you will need to sign a Contributor License Agreement (CLA).

If you are signing as an individual, we recommend that you talk to your employer (if applicable) before signing the CLA since some employment agreements may have restrictions on your contributions to other projects.
Otherwise by submitting a CLA you represent that you are legally entitled to grant the licenses recited therein.

If your employer has rights to intellectual property that you create, such as your contributions, you represent that you have received permission to make contributions on behalf of that employer, that your employer has waived such rights for your contributions, or that your employer has executed a separate CLA with F5.

If you are signing on behalf of a company, you represent that you are legally entitled to grant the license recited therein.
You represent further that each employee of the entity that submits contributions is authorized to submit such contributions on behalf of the entity pursuant to the CLA.