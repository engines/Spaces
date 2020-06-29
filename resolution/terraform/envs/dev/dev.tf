# ------------------------------------------------------------
# Let terraform know about LXD.
# ------------------------------------------------------------
provider "lxd" {
  # This works using the local unix domain socket. You MUST be in the lxd group.
  generate_client_certificates = true
  accept_remote_certificate    = true
}

# ------------------------------------------------------------
# The default pool from which contain volumes.
# ------------------------------------------------------------
variable "pool_properties" {
  default = {
    "path" = "/"
    "pool" = "default"
  }
}

# ------------------------------------------------------------
# The command to run propellor. In case you're wondering why
# this looks so odd it's me simply being lazy. I don't want to
# change the permissions of /tmp/propellor-config" so I just
# run it with the dynamic linker.
# ------------------------------------------------------------
variable "run-propellor" {
  default = [ "/lib64/ld-linux-x86-64.so.2 /tmp/propellor-config" ]
}


# ------------------------------------------------------------
# postgres container
# ------------------------------------------------------------
resource "lxd_container" "postgres" {
  name      = "postgres"
  image     = "engines/beowulf/base/20200623/1143"
  ephemeral = false

  device {
    name        = "root"
    type        = "disk"
    properties  = var.pool_properties
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
    inline = var.run-propellor

    connection {
      type     = "ssh"
      user     = "root"
      host     = self.ipv6_address
    }
  }
}


# ------------------------------------------------------------
# rails container
# ------------------------------------------------------------
resource "lxd_container" "rails" {
  name      = "rails"
  image     = "engines/beowulf/base/20200623/1143"
  ephemeral = false

  device {
    name        = "root"
    type        = "disk"
    properties  = var.pool_properties
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
    inline = var.run-propellor
    # inline = [
    #   "/lib64/ld-linux-x86-64.so.2 /tmp/propellor-config"
    # ]

    connection {
      type     = "ssh"
      user     = "root"
      host     = self.ipv6_address
    }
  }
}


# ------------------------------------------------------------
# wap container
# ------------------------------------------------------------
resource "lxd_container" "wap" {
  name      = "wap"
  image     = "engines/beowulf/base/20200623/1143"
  ephemeral = false

  device {
    name        = "root"
    type        = "disk"
    properties  = var.pool_properties
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
    inline = var.run-propellor

    connection {
      type     = "ssh"
      user     = "root"
      host     = self.ipv6_address
    }
  }
}
