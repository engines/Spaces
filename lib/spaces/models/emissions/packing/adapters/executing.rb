require_relative 'pack'

module Adapters
  class Execution < Pack
    include Keyed

      def adapter_keys
        [:execution]
      end

  end
end
