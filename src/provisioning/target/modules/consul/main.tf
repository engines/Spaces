resource "consul_node" "turtle" {
  name    = var.srv_node
  address = var.srv_addr
}

resource "consul_service" "turtle" {
  name = var.srv_name
  node = consul_node.turtle.name
  port = var.srv_port
}
