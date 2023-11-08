#---------------------
# Create policies
#---------------------

# Create admin policy in the root namespace
resource "vault_policy" "admin_policy" {
  name   = "admins"
  policy = file("policies/admin-policy.hcl")
}

# Create user policy in the root namespace
resource "vault_policy" "user_policy" {
  name   = "admins"
  policy = file("policies/user-policy.hcl")
}

