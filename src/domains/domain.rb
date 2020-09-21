require_relative '../emitting/division'
require_relative '../defaultables/defaultable'

module Domains
  class Domain < ::Emitting::Division
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
