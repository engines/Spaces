variable "srv_name" {
  description = "The Service entry name"
  type = string
}

variable "srv_node" {
  description = "The name of the node that the service runs on"
  type = string
}

variable "srv_port" {
  description = "The Service entry port number"
  type = number
}

variable "srv_addr" {
  description = "The Service ip addr"
  type = string
}
