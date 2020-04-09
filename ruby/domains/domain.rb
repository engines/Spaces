require_relative '../installations/collaborator'

module Domains
  class Domain < ::Installations::Collaborator

    class << self
      def inheritance_paths; __dir__; end
    end

    require_files_in :steps

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
      @default ||= OpenStruct.new(fqdn: fqdn, host: host, name: name)
    end

  end
end
