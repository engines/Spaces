module Divisions
  class ServiceTasks < ::Divisions::Division

    def connection_stanza_for(binding)
      connect&.map do |c|
        %(
          provisioner "local-exec" {
            command = "lxc exec #{blueprint_identifier} #{binding.environment_variables} #{c}"
          }
        )
      end.join
    end

  end
end
