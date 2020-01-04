require_relative '../spaces/model'

module Domain
  class Domain < ::Spaces::Model

    def layers(software)
      %Q(
        ENV Hostname '#{software.title}'
        ENV Domainname '#{struct.name}'
        ENV fqdn '#{software.title}.#{struct.name}'
      )
    end

  end
end
