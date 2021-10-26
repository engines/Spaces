module Adapters
  module Precedence

    def precedence
      [:images, :first, :configuration, :early, :adds, :middle, :permissions, :removes, :late, :last, :execution]
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
