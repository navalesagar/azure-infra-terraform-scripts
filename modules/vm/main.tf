# Public IP for VM
resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"  # CIS: Use static for better security
  sku                 = "Standard"  # CIS: Use Standard SKU

  tags = var.tags
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = var.tags
}

# Storage Account for Boot Diagnostics (CIS: Enable boot diagnostics)
resource "azurerm_storage_account" "boot_diag" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"  # CIS: Use TLS 1.2

  tags = var.tags
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  # CIS: Use SSH key instead of password
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  # CIS: Use managed disks
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }

  # CIS: Enable boot diagnostics
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.boot_diag.primary_blob_endpoint
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-comics-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # SSH Key
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  tags = var.tags
}