require_relative 'script'

module Interpolating
  class OneTimeScript < Script

    def identifier
      qualifier
    end

  end
end
