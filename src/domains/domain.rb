require_relative '../releases/component'
require_relative '../defaultables/defaultable'

module Domains
  class Domain < ::Releases::Component
    include Defaultables::Defaultable

    def fqdn
      "#{host}.#{name}"
    end

    def host
      context_identifier
    end

    def name
      'current.engines.org'
    end

    def default
      OpenStruct.new(fqdn: fqdn, host: host, name: name)
    end

  end
end
