resource "docker_container" "container" {
  image     = var.image
  name      = var.name
}
