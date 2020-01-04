require_relative '../spaces/model'

module Spaces
  class Space < Model

    class << self
      def universe
        require_relative '../universal/space'
        @@universe ||= Universal::Space.new
      end
    end

    def universe
      self.class.universe
    end

    def ensure_space
      FileUtils.mkdir_p(path)
    end

    def path
      "#{universe.path}/#{identifier}"
    end

  end
end
