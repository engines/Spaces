require_relative '../spaces/defaultables/defaultable'
require_relative '../emitting/emissions/division'

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
