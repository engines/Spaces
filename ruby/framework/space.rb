require_relative '../framework/model'

module Framework
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

    def path
      "#{universal.path}/#{identifier}"
    end

  end
end
