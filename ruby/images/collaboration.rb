require_relative '../spaces/product'

module Images
  module Collaboration

    def script_precedence
      self.class.script_precedence
    end

    def scripts
      script_precedence.map { |s| scoped_class(s).new(self) }
    end

  end
end
