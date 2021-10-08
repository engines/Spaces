module Divisions
  class Volume < ::Divisions::Subdivision

    class << self
      def features; [:source, :destination] ;end
    end

    alias_method :identifier, :context_identifier

    delegate device_snippets: :provider_division_aspect

  end
end
