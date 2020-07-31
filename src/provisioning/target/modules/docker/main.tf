resource "docker_container" "docker" {
  name      = var.name
  ephemeral = false

  device {
    name        = "root"
    type        = "disk"

    properties  = {
      "path" = "/"
      "pool" = "default"
    }
  }

  config = {
    "boot.autostart" = true
  }
}
