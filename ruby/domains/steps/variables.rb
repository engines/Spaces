require_relative '../../docker/files/step'

module Domains
  module Steps
    class Variables < Docker::Files::Step

      def content
        %Q(
        ENV Hostname '#{context.identifier}'
        ENV Domainname 'current.spaces.org'
        ENV fqdn '#{context.identifier}.current.spaces.org'
        )
      end

    end
  end
end
