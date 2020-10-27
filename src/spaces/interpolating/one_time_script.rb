module Interpolating
  require_relative 'script'
  require_relative 'text'
  class OneTimeScript < Script

    def identifier
      qualifier
    end

  end
end
