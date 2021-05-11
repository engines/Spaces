module Divisions
  class Ports < ::Divisions::Divisible
    def lxc_commisioning_script
      %(
      provisioner = "local-exec" {
            command = #{command}
     )
    end

    def command
#which arena.configuration.address}|| lxd.lxd_remote.address || ???
      c = "/usr/local/bin/open_port.sh -h #{lxd.lxd_remote.address} -p #{protocol} -e #{external_port} -s #{start_port}"
      c = "#{c}:#{end_port}" unless end_port.nil?
      c
    end

    def docker_paramater_hash
      {}
    end
  end
end
