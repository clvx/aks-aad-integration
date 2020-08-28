variable "sp_client_id" {}
variable "sp_client_secret" {}

# AKS config

variable "agent_count" {
  default = 1
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
}

variable cluster_name {
}

variable resource_group_name {
}

variable "location" {
}

# Config for vm

variable "admin_username" {
  default     = ""
  description = "Administrator user name for virtual machine"
}

variable "tags" {
  default = {
    Environment = "Development"
    Dept        = "Engineering"
  }
}

#AD configuration

variable "aad_organization" {
  default = ""
}

variable "aad_user_password" {
  default = ""
}

#Terraform backend

variable "tf_backend_rg" {
  default = ""
}

variable "tf_backend_storage" {
  default = ""
}
