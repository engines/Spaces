require_relative '../nodule'

module Nodules
  module Pear
    class Pear < Nodule
      Dir["#{__dir__}/scripts/*"].each { |f| require f }

      class << self
        def script_lot
          @@pear_script_lot ||= [:preparation, :installation, :finalisation]
        end
      end

    end
  end
end
