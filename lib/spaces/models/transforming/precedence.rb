module Transforming
  module Precedence

    def precedence
      [:images, :first, :early, :adds, :middle, :permissions, :removes, :late, :last]
    end

    def precedence_for(qualifier)
      if precedence.include?(q = qualifier.to_sym)
        q
      else
        :middle
      end
    end

  end
end
