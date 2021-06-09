module Divisions
  class Ports < ::Divisions::Divisible
    
    def stanzas
      %(
        provisioner = "local-exec" {
          command = "#{commands}"
        }
      )
    end

    def commands
      all.map(&:command).join("\n")
    end

  end
end
