require_relative '../../docker/files/step'

module Domains
  module Steps
    class Variables < Docker::Files::Step

      def instructions
        %Q(
        ENV Hostname '#{context.host}'
        ENV Domainname '#{context.name}'
        ENV fqdn '#{context.fqdn}'
        )
      end

    end
  end
end
