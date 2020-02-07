require_relative '../nodule'

module Nodules
  class R < Nodule

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def identifier
        'r'
      end
    end

  end
end
