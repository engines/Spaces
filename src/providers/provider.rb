module Providers
  class Provider < ::Spaces::Model

    class << self
      def identifier; qualifier ;end
    end

  end
end
