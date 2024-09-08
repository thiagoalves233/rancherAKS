variable "project" {
  type    = list(string)
}



resource "rancher2_project" "project" {
  for_each = toset(var.project)
  name = each.value
  cluster_id = "local"
}