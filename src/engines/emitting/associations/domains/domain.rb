module Associations
  class Domain < ::Emissions::Association

    class << self
      def default_struct
        OpenStruct.new(identifier: 'current.engines.org')
      end
    end

  end
end
