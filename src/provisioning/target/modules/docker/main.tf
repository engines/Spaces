resource "docker_container" "turtle" {
  image     = var.image
  name      = var.name
}
