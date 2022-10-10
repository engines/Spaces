module Associations
  class Domain < ::Divisions::Subdivision

    def name = identifier
    def qualified_name = "#{context_identifier.as_subdomain}.#{identifier}"

    alias_method :fqdn, :qualified_name
  end
end
