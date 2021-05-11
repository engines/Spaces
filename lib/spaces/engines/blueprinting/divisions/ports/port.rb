module Divisions
  class Port < ::Divisions::Subdivision

    class << self
      def features; [:start_port, :end_port :protocol, :external_port] ;end
    end

  end
end
