module Divisions
  class Volume < ::Divisions::Subdivision

    class << self
      def features; [:type, :source, :destination] ;end
    end

    alias_method :identifier, :context_identifier

    def type
      struct.type || 'volume'
    end

  end
end
