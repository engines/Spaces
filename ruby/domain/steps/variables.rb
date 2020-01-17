require_relative 'requires'

module Domain
  class Variables < Container::Docker::Step

    def content
      %Q(
        ENV Hostname '#{context.struct.identifier}'
        ENV Domainname 'current.spaces.org'
        ENV fqdn '#{context.struct.identifier}.current.spaces.org'
      )
    end
  end
end
