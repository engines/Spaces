resource "powerdns_zone" "dns" {
  name        = "${var.zone}."
  kind        = "Native"
  nameservers = ["ns.${var.zone}."]
}
