variable "datacentre" {
  default = "dh"
}

variable "zone" {
  default = "engines.org"
}

variable "dns_ttl" {
  default = 120
}

variable "pdns_server_url" {
  default = "http://[fd61:d025:74d7:f46a::ffff]:8081/api/v1"
}

variable "pdns_api_key" {
  default = "369db357c9599dbee19400aaf1d14f98a5e8bb902f3c69a271f0cbacecb1126f"
}

