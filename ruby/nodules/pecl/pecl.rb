require_relative '../nodule'

module Nodule
  class Pecl < Nodule

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def identifier
        'pecl'
      end
    end

  end
end
