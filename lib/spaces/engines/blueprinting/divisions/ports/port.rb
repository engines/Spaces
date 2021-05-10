module Divisions
  class Port < ::Divisions::Subdivision

    class << self
      def features; [:port, :protocol, :external_port] ;end
    end

  end
end
