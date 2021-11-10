module Associations
  class Domain < ::Divisions::Association

    class << self
      def default_struct
        OpenStruct.new(identifier: default_identifier)
      end

      def default_identifier; 'localhost'; end
    end

    def name; identifier ;end
    def qualified_name; "#{context_identifier.as_subdomain}.#{identifier}" ;end

    alias_method :fqdn, :qualified_name
  end
end
