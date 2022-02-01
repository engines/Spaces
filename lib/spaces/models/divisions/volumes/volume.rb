module Divisions
  class Volume < ::Divisions::Subdivision

    class << self
      def features; [:type, :name, :destination] ;end
    end

    alias_method :identifier, :context_identifier

    def source
      "#{volume_path}/#{name}/#{identifier.as_path}"
    end

    def mount?; type == default_type; end

    def type; struct.type || 'mount' ;end
    def default_type; 'mount' ;end

  end
end
