require_relative '../spaces/model'

module Spaces
  class Space < Model

    class << self
      def universal
        require_relative '../universal/space'
        @@universal ||= Universal::Space.new
      end
    end

    def universal
      self.class.universal
    end

    def ensure_space
      FileUtils.mkdir_p(path)
    end

    def path
      "#{universal.path}/#{identifier}"
    end

  end
end
