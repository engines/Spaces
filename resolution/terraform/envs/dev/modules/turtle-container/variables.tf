variable "name" {
  description = "Name of the container. Must be unique."
  type = string
}

variable "image" {
  description = "Name of the image to use when building the container. This must exist in the LXD image store."
  type = string
}
