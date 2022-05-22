######################
# RANCHER VARIABLES  #
######################
variable "rancher_url" {
  description = "Rancher Management Server URL"
  type        = string
}

variable "rancher_api_key" {
  description = "Rancher API KEY"
  type      = string
  sensitive = true
}



