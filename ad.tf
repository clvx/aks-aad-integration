resource "azuread_user" "sre" {
  user_principal_name = "sre@${var.aad_organization}"
  display_name        = "sre"
  password            = var.aad_user_password
}

resource "azuread_user" "qa" {
  user_principal_name = "qa@${var.add_organization}"
  display_name        = "qa"
  password            = var.aad_user_password
}

resource "azuread_user" "dev" {
  user_principal_name = "dev@${var.add_organization}"
  display_name        = "dev"
  password            = var.aad_user_password
}

resource "azuread_group" "aksroot" {
  name        = "aksroot"
  description = "AKS admin group"
}

resource "azuread_group" "aksdev" {
  name        = "aksdev"
  description = "AKS dev group"
}

resource "azuread_group" "aksqa" {
  name        = "aksqa"
  description = "AKS qa group"
}

resource "azurerm_role_assignment" "aksroot" {
  scope                = azurerm_kubernetes_cluster.k8s.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_group.aksroot.object_id
}

resource "azurerm_role_assignment" "aksqa" {
  scope                = azurerm_kubernetes_cluster.k8s.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_group.aksqa.object_id
}

resource "azurerm_role_assignment" "aksdev" {
  scope                = azurerm_kubernetes_cluster.k8s.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_group.aksdev.object_id
}

resource "azuread_group_member" "aksroot" {
  group_object_id  = azuread_group.aksroot.object_id
  member_object_id = azuread_user.sre.object_id
}

resource "azuread_group_member" "aksqa" {
  group_object_id  = azuread_group.aksqa.object_id
  member_object_id = azuread_user.qa.object_id
}

resource "azuread_group_member" "aksdev" {
  group_object_id  = azuread_group.aksdev.object_id
  member_object_id = azuread_user.dev.object_id
}
