###########################
## Azure Provider - Main ##
###########################

# Define Terraform provider
terraform {
  required_version = ">= 0.12"
}

# Configure the Azure provider
provider "azurerm" {
  environment = "public"
  version     = ">= 2.7.0"
  features {}
  subscription_id = var.azure-subscription-id
  client_id       = var.azure-client-id
  client_secret   = var.azure-client-secret
  tenant_id       = var.azure-tenant-id
}



###########################
# Create a Resource Group
###########################

resource "azurerm_resource_group" "rg" {
  name     = "dev-rg"
  location = var.location
}


resource "azurerm_virtual_network" "vnet" {
  name                = "dev-vnet"
  address_space       = [var.vnet]
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
}


###########################
# Create a Gateway Subnet
###########################

resource "azurerm_subnet" "gateway-subnet" {
  name                 = "GatewaySubnet" # do not rename
  address_prefixes     = [var.gateway-subnet]
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  resource_group_name  = azurerm_resource_group.hub-rg.name
}


###########################
# Create a private Subnet
###########################

resource "azurerm_subnet" "psubnet" {
  name                 = "private-subnet" # do not rename
  address_prefixes     = [var.private-subnet]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}


resource "azurerm_network_security_group" "nsg" {
  name                = "dev-nsg"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}


resource "azurerm_network_security_rule" "rulessh" {
  name                        = "dev-rulessh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}


resource "azurerm_network_security_rule" "rulehttps" {
  name                        = "dev-rulehttps"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}
