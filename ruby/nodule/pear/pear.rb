require_relative '../nodule'

module Nodule
  class Pear < Nodule

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def identifier
        'pear'
      end
    end

  end
end
