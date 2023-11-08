# Used and adapted the example from https://developer.hashicorp.com/vault/tutorials/operations/codify-mgmt-enterprise
#---------------------------------------------------------------
# Create nested namespaces
#   education has childnamespace, 'training' 'ns1'  'ns2'
#       training has childnamespace, 'secure'
#           secure has childnamespace, 'vault_cloud'  'boundary' 'ns111'  'ns112'
#---------------------------------------------------------------
provider "vault" {
}

resource "vault_namespace" "education" {
  path = "education"
}

variable "child_namespaces_1" {
  type = set(string)
  default = [
    "ns1",
    "ns2",
  ]
}

variable "child_namespaces_2" {
  type = set(string)
  default = [
    "vault_cloud",
    "boundary",
    "ns111",
    "ns112",
  ]
}

# First level of child namespaces
resource "vault_namespace" "children1" {
  for_each  = var.child_namespaces_1
  namespace = vault_namespace.education.path
  path      = each.key
}

# Create a childnamespace, 'training' under 'education'
resource "vault_namespace" "training" {
  namespace = vault_namespace.education.path
  path = "secure"
}

# Create a childnamespace, 'secure' under 'training'
resource "vault_namespace" "secure" {
  namespace = vault_namespace.training.path_fq
  path = "secure"
}

resource "vault_namespace" "children2" {
  for_each  = var.child_namespaces_2
  namespace = vault_namespace.secure.path_fq
  path      = each.key
}

