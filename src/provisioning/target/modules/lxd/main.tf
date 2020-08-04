
output "name" {
  value = lxd_container.turtle.name
}

output "ipv4_address" {
  value = lxd_container.turtle.ipv4_address
}

output "ipv6_address" {
  value = lxd_container.turtle.ipv6_address
}


resource "lxd_container" "turtle" {
  name      = var.name
  image     = var.image
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

  # This only exists because the host name is not in DNS so
  # it doesn't know who it is which breaks propellor.
  provisioner "file" {
    content     = "127.0.1.1\t${self.name}.int.engines.org ${self.name}\n127.0.0.1\tlocalhost\n::1\tlocalhost\nff02::1\tip6-allnodes\nff02::2i\tip6-allrouters"
    destination = "/etc/hosts"

    connection {
      type     = "ssh"
      user     = "root"
      host     = self.ipv6_address
    }
  }

  # Copy propellor over to the container
  provisioner "file" {
    source      = "/tmp/propellor-config"
    destination = "/tmp/propellor-config"

    connection {
      type     = "ssh"
      user     = "root"
      host     = self.ipv6_address
    }
  }

  # Run propellor.
  provisioner "remote-exec" {
    inline = [ "/lib64/ld-linux-x86-64.so.2 /tmp/propellor-config" ]

    connection {
      type     = "ssh"
      user     = "root"
      host     = self.ipv6_address
    }
  }
}


resource "powerdns_record" "AAAA" {
  zone    = var.zone
  name    = "${lxd_container.turtle.name}.${var.zone}."
  type    = "AAAA"
  ttl     = var.dns_ttl
  records = ["${lxd_container.turtle.ipv6_address}"]
}
