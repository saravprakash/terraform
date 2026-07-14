locals {
  resource_group_name = lower("${var.application_name}-${var.location}-${var.env}-rsg-01")
  vnet_name           = lower("${var.application_name}-${var.location}-${var.env}-vnet-01")

  # Subnet configuration: subnet_name = CIDR
  subnets_config = {
    "${var.application_name}-${var.location}-${var.env}-pe-snet"   = "10.0.0.0/28"   # Private Endpoints
    "${var.application_name}-${var.location}-${var.env}-swa-snet"  = "10.0.0.16/28"  # Static Web App
    "${var.application_name}-${var.location}-${var.env}-faob-snet" = "10.0.0.32/28"  # Function App Outbound
    "${var.application_name}-${var.location}-${var.env}-laob-snet" = "10.0.0.48/28"  # Logic App Outbound
    "${var.application_name}-${var.location}-${var.env}-aks-snet" = "10.0.0.64/26"  # AKS Subnet
  }

  # Service endpoints configuration: subnet_name = [list of service endpoints]
  service_endpoints_config = {
    "${var.application_name}-${var.location}-${var.env}-pe-snet"   = ["Microsoft.Storage", "Microsoft.KeyVault"]
    "${var.application_name}-${var.location}-${var.env}-swa-snet"  = ["Microsoft.Web"]
    "${var.application_name}-${var.location}-${var.env}-faob-snet" = ["Microsoft.Storage", "Microsoft.Sql"]
    "${var.application_name}-${var.location}-${var.env}-laob-snet" = ["Microsoft.Storage", "Microsoft.ServiceBus"]
    "${var.application_name}-${var.location}-${var.env}-aks-snet" = ["Microsoft.ContainerRegistry", "Microsoft.KeyVault"]
  }


  subnet_delegations = {
    "${var.application_name}-${var.location}-${var.env}-pe-snet" = {
        name = "Microsoft.Web/serverFarms"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
        ]
    }
  }







}

