module Adapters
  module Precedence

    def precedence
      [:first, :images, :configuration, :early, :adds, :middle, :permissions, :removes, :late, :last]
    end

    def precedence_for(qualifier)
      if precedence.include?(q = :"#{qualifier}")
        q
      else
        :middle
      end
    end

  end
end
