#--------------------------------
# Enable userpass auth method
#--------------------------------
resource "vault_auth_backend" "myuserpass_resource" {
  type = "userpass"
  path = "myuserpass"
  tune {
    max_lease_ttl      = "90000s"
    listing_visibility = "hidden"
  }
}

# Create a user named, "dockertest"
resource "vault_generic_endpoint" "dockertest" {
  depends_on           = [vault_auth_backend.myuserpass_resource]
  path                 = "auth/myuserpass/users/dockertest"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["admins"],
  "password": "notsecure"
}
EOT
}
