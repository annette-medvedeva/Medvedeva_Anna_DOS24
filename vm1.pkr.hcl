# Define variables for SSH credentials
variable "ssh_username" {
  description = "The username for SSH access"
  default     = "my_user"  # Replace with your desired username
}

variable "ssh_password" {
  description = "The password for SSH access"
  default     = "my_secure_password"  # Replace with your desired password
}

# Define the source for the virtual machine
source "virtualbox-iso" "vm1" {
  iso_url            = "/home/anna/Downloads/ubuntu-24.04.1-live-server-amd64.iso">
  iso_checksum       = "sha256:e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ce>
  ssh_username       = var.ssh_username
  ssh_password       = var.ssh_password
  disk_size          = 20480  # Size of the virtual disk in MB
  guest_os_type      = "Ubuntu_64"  # Type of guest OS
  boot_command       = [
    "<esc><wait>",      # Press Escape
    "install<wait>",   # Start the installation
    "<enter><wait>"     # Press Enter to continue
  ]
}
