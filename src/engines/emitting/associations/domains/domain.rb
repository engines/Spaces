module Associations
  class Domain < ::Emissions::Association

    class << self
      def default_struct
        OpenStruct.new(identifier: 'current.engines.org')
      end
    end

    def name; identifier ;end
    def qualified_name; "#{context_identifier}.#{identifier}" ;end
    
    alias_method :fqdn, :qualified_name
  end
end
