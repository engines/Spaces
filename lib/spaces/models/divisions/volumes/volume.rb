module Divisions
  class Volume < ::Divisions::Subdivision

    class << self
      def features; [:type, :source, :destination] ;end
    end

    alias_method :identifier, :context_identifier

    def bind?; type == default_type; end

    def type; struct.type || 'bind' ;end
    def default_type; 'bind' ;end

  end
end
