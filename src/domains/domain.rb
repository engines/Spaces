require_relative '../releases/division'

module Domains
  class Domain < ::Releases::Division

    def fqdn
      "#{host}.#{name}"
    end

    def host
      context_identifier
    end

    def name
      'current.spaces.org'
    end

    def default
      @default ||= OpenStruct.new(fqdn: fqdn, host: host, name: name)
    end

  end
end
