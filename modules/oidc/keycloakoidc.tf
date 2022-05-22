#Temporary API access token created for the API Curl command below
resource "rancher2_token" "auth" {
  provider = rancher2
  ttl = 1200
}

#Keycloak ODIC Rancher API endpoint
resource "null_resource" "configure_keycloak_oidc" {
  provisioner "local-exec" {
      command =  <<EOT
       curl -k --insecure -u '${rancher2_token.auth.access_key}:${rancher2_token.auth.secret_key}'  \
        -X PUT \
        -H 'Accept: application/json' \
        -H 'Content-Type: application/json' \
        -d '{    "accessMode": "${var.keycloakoidc_accessMode}", 
                 "allowedPrincipalIds": ["${var.keycloakoidc_user}","${join("\" , \"",var.keycloakoidc_allowedPrincipalIds)}"],
                 "authEndpoint": "${var.keycloakoidc_authEndpoint}",  
                 "clientId": "${var.keycloakoidc_clientid}", 
                 "clientSecret": "${var.keycloakoidc_clientsecret}",  
                 "created": "2021-09-12T17:08:02Z",   
                 "creatorId": null,    "enabled": true,   
                 "groupSearchEnabled": null,   
                 "issuer": "${var.keycloakoidc_issuer}",   
                 "labels": {        "cattle.io/creator": "norman"    },   
                 "name": "keycloakoidc",   
                 "ownerReferences": [ ],   
                 "rancherUrl": "${var.keycloakoidc_rancherUrl}",   
                 "scope": "openid profile email",    "type": "keyCloakOIDCConfig"}' \
       ${var.rancher_url}/v3/keyCloakOIDCConfigs/keycloakoidc?action=testAndApply > /tmp/result.txt
EOT
  }
  triggers = {
    #Forces execution of API call on each "terraform apply", otherwise it's only ran the first time
    always_run = timestamp()
  }
}
