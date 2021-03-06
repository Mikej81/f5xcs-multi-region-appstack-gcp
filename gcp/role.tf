terraform {
  required_version = ">= 0.13.0"
  required_providers {
    google = {
      version = "4.15.0"
    }
  }
}

# Memes did some https://github.com/memes/terraform-google-volterra/blob/main/modules/service-account/main.tf
# https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google/latest
# https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/custom_role_iam

module "custom-roles" {
  source = "terraform-google-modules/iam/google//modules/custom_role_iam"

  target_level = "project"
  target_id    = var.projectName
  role_id      = ""
  title        = "XCS GCP Role"
  description  = "GCP role to create XCS GCP VPC site"
  members      = ""
  permissions = compact(concat(
    [
      "compute.backendServices.create",
      "compute.backendServices.delete",
      "compute.backendServices.get",
      "compute.backendServices.list",
      "compute.disks.create",
      "compute.disks.delete",
      "compute.disks.get",
      "compute.disks.list",
      "compute.disks.resize",
      "compute.firewalls.create",
      "compute.firewalls.delete",
      "compute.firewalls.get",
      "compute.firewalls.list",
      "compute.firewalls.update",
      "compute.forwardingRules.create",
      "compute.forwardingRules.delete",
      "compute.forwardingRules.get",
      "compute.forwardingRules.list",
      "compute.globalOperations.get",
      "compute.healthChecks.create",
      "compute.healthChecks.delete",
      "compute.healthChecks.get",
      "compute.healthChecks.list",
      "compute.healthChecks.useReadOnly",
      "compute.images.create",
      "compute.images.get",
      "compute.images.list",
      "compute.images.useReadOnly",
      "compute.instanceGroupManagers.create",
      "compute.instanceGroupManagers.delete",
      "compute.instanceGroupManagers.get",
      "compute.instanceGroupManagers.list",
      "compute.instanceGroupManagers.update",
      "compute.instanceGroups.create",
      "compute.instanceGroups.delete",
      "compute.instanceGroups.get",
      "compute.instanceGroups.list",
      "compute.instanceGroups.use",
      "compute.instanceTemplates.create",
      "compute.instanceTemplates.delete",
      "compute.instanceTemplates.get",
      "compute.instanceTemplates.list",
      "compute.instanceTemplates.useReadOnly",
      "compute.instances.attachDisk",
      "compute.instances.create",
      "compute.instances.delete",
      "compute.instances.deleteAccessConfig",
      "compute.instances.detachDisk",
      "compute.instances.get",
      "compute.instances.list",
      "compute.instances.reset",
      "compute.instances.resume",
      "compute.instances.setLabels",
      "compute.instances.setMachineResources",
      "compute.instances.setMachineType",
      "compute.instances.setMetadata",
      "compute.instances.setServiceAccount",
      "compute.instances.setTags",
      "compute.instances.start",
      "compute.instances.stop",
      "compute.instances.update",
      "compute.instances.updateAccessConfig",
      "compute.instances.updateNetworkInterface",
      "compute.instances.use",
      "compute.machineTypes.list",
      "compute.networkEndpointGroups.attachNetworkEndpoints",
      "compute.networks.access",
      "compute.networks.create",
      "compute.networks.delete",
      "compute.networks.get",
      "compute.networks.list",
      "compute.networks.update",
      "compute.networks.updatePolicy",
      "compute.networks.use",
      "compute.networks.useExternalIp",
      "compute.regionBackendServices.create",
      "compute.regionBackendServices.delete",
      "compute.regionBackendServices.get",
      "compute.regionBackendServices.list",
      "compute.regionBackendServices.use",
      "compute.regionOperations.get",
      "compute.routes.create",
      "compute.routes.delete",
      "compute.routes.get",
      "compute.routes.list",
      "compute.subnetworks.create",
      "compute.subnetworks.delete",
      "compute.subnetworks.get",
      "compute.subnetworks.list",
      "compute.subnetworks.setPrivateIpGoogleAccess",
      "compute.subnetworks.update",
      "compute.subnetworks.use",
      "compute.subnetworks.useExternalIp",
      "compute.zones.get",
      "iam.serviceAccounts.actAs",
      "iam.serviceAccounts.get",
      "iam.serviceAccounts.list",
      "resourcemanager.projects.get"
  ]))
}
