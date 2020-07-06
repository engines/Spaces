require_relative '../releases/division'

module Starters
  class Starter < ::Releases::Division

    def identifier; struct.identifier || image.gsub('/', '_') ;end
    def platform; struct.platform ;end

  end
end
