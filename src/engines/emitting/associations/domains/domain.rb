module Associations
  class Domain < ::Emissions::Division

    def fqdn
      "#{host}.#{name}"
    end

    def host
      context_identifier
    end

    def name
      'current.engines.org'
    end

    def default_struct
      OpenStruct.new(fqdn: fqdn, host: host, name: name)
    end

  end
end
