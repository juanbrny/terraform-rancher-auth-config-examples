locals {

  roles = distinct(flatten([ 
    for cluster_group in var.cluster_groups : [ 
      for cluster_role in cluster_group.cluster_roles : cluster_role
    ]
  ]))

  role_bindings = flatten([ 
    for cluster_group_key,cluster_group in var.cluster_groups : [ 
      for cluster_role in cluster_group.cluster_roles : {
        "${cluster_group_key}-${cluster_role}" = {
          group_id = cluster_group_key
          role_id = data.rancher2_role_template.roles[cluster_role].id
        }
      }
    ]
  ])

  role_bindings_map = {
    for role_binding in local.role_bindings :
      keys(role_binding)[0] => values(role_binding)[0]
  }

}

data "rancher2_cluster" "k8s_cluster" {
  name=var.cluster_name
}

data "rancher2_role_template" "roles" {
    for_each = toset(local.roles)
    name = each.value
}

resource "rancher2_cluster_role_template_binding" "group_role_binding" {
  for_each = local.role_bindings_map

  name = "${replace(replace(replace(each.value.group_id, ":", "-"),"/", "-"),"_","-")}-${each.value.role_id}"
  cluster_id = data.rancher2_cluster.k8s_cluster.id
  role_template_id = each.value.role_id
  group_principal_id = each.value.group_id
  
}





