# ------------------------------------------------------------
# Let terraform know about LXD.
# ------------------------------------------------------------
provider "lxd" {
  # This works using the local unix domain socket. You MUST be in the lxd group.
  generate_client_certificates = true
  accept_remote_certificate    = true
}


# ------------------------------------------------------------
# ^^identifier^^ container
# ------------------------------------------------------------

module "^^identifier^^" {
  source = "./modules/turtle-container"
  name  = "^^identifier^^"
  image = "engines/beowulf/base/20200623/1143"
}
