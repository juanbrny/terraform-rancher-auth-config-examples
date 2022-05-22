variable "cluster_name" {
    type = string
    description = "Name of the cluster"
    default = "singlenodetest2"

    validation {
        condition     = length(regexall("[a-z0-9]([-a-z0-9]*[a-z0-9])?", var.cluster_name)) > 0
        error_message = "The cluster name is not correct."
    }
}

variable "cluster_groups" {
  type = map(object({
    cluster_roles = list(string)
  }))
  description = "list of groups to add to this cluster"
  default = {
      "keycloakoidc_group://rancherusers" = {
        cluster_roles = ["Cluster Owner"]
        #cluster_roles = ["Cluster Owner","Cluster Member"]
    }
  }
}
