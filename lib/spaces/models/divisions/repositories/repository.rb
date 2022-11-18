module Divisions
  class Repository < ::Divisions::Subdivision

    class << self
      def features = [:identifier, :name, :domain, :type, :content]
    end

    def identifier = struct.identifier || name

  end
end
