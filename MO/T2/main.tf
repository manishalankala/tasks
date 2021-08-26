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

###########################

###########################

resource "azurerm_network_security_group" "nsg" {
  name                = "dev-nsg"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

###########################
# Inbound- ssh
###########################


resource "azurerm_network_security_rule" "rulessh" {
  name                        = "dev-rulessh"
  priority                    = 301
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

###########################
# Inbound - https
###########################


resource "azurerm_network_security_rule" "rulehttps" {
  name                        = "dev-rulehttps"
  priority                    = 302
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


###########################
Public IP
###########################

resource "azurerm_public_ip" "pip" {
  name                         = "pub-ip"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "dynamic"
}



###########################
# Storage 
###########################

resource "azurerm_storage_account" "store" {
  name                = "dev-store"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  account_type        = "Standard_LRS"
}


###########################
# Container
###########################
resource "azurerm_storage_container" "storec" {
  name                  = "dev-storec"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  storage_account_name  = "${azurerm_storage_account.store.name}"
  container_access_type = "private"
}


resource "azurerm_virtual_machine" "vm" {
  name                  = "vm1"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name          = "${var.name_prefix}osdisk"
    vhd_uri       = "${azurerm_storage_account.stor.primary_blob_endpoint}${azurerm_storage_container.storc.name}/${var.name_prefix}osdisk.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.hostname}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = "${var.disable_password_authentication}"

    ssh_keys = [{
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${var.ssh_public_key}"
    }]
  }

  depends_on = ["azurerm_storage_account.stor"]
}
