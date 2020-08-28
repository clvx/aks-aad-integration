output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw
}

output "host" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.host
}

output "aksroot_object_id" {
  value = azuread_group.aksroot.object_id
}

output "aksqa_object_id" {
  value = azuread_group.aksqa.object_id
}

output "aksdev_object_id" {
  value = azuread_group.aksdev.object_id
}
