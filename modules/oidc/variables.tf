variable "rancher_url" {
  description = "rancher_url"
  type        = string
  default = "https://rancher26.home.brainy.es"
}

variable "keycloakoidc_clientid" {
  description = "keycloakoidc_clientid"
  type        = string
  default = "rancher26"
}

variable "keycloakoidc_clientsecret" {
  description = "keycloakoidc_clientsecret"
  type        = string
  sensitive = true
  default = "V4yyAdhZ30Hyoqz1YE0zJZVrdpzHwyV6"
}

variable "keycloakoidc_user" {
  description = "keycloakoidc_user"
  type        = string
  default = "keycloakoidc_user://8c2ef9f9-1cbb-4146-839b-0a4410b0b91c"
}

variable "keycloakoidc_accessMode" {
  #One of: "unrestricted" "restricted" "required"
  description = "keycloakoidc_accessMode"
  type        = string
  default = "unrestricted"
}

variable "keycloakoidc_allowedPrincipalIds" {
    description = "keycloakoidc_principalIds"
    type = list(string)
    default=["keycloakoidc_group://rancheradmins","keycloakoidc_group://rancherusers"]
}

variable "keycloakoidc_authEndpoint" {
  description = "keycloakoidc_authEndpoint URL"
  type        = string
  default = "http://keycloak.home.brainy.es/realms/rancher/protocol/openid-connect/auth"
  validation {
    condition= can(regex("https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)",var.keycloakoidc_authEndpoint))
    error_message = "Invalid URL format."
  }
}

variable "keycloakoidc_issuer" {
  description = "keycloakoidc_authEndpoint issuer"
  type        = string
  default = "http://keycloak.home.brainy.es/realms/rancher"
  validation {
    condition= can(regex("https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)",var.keycloakoidc_issuer))
    error_message = "Invalid URL format."
  }
}

variable "keycloakoidc_rancherUrl" {
  description = "keycloakoidc_authEndpoint rancherUrl"
  type        = string
  default = "https://rancher26.home.brainy.es/verify-auth"
  validation {
    condition= can(regex("https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)",var.keycloakoidc_rancherUrl))
    error_message = "Invalid URL format."
  }
}



