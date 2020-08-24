variable "client_id" {}
variable "client_secret" {}

# AKS config

variable "agent_count" {
    default = 1
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "rbac"
}

variable cluster_name {
    default = "k8srbac"
}

variable resource_group_name {
    default = "devopspe"
}

variable "location" {
    default = "westus2"
}

# Config for vm

variable "admin_username" {
    default = ""
    description = "Administrator user name for virtual machine"
}

variable "tags" {
    default = {
        Environment = "Development"
        Dept = "Engineering"
    }
}
