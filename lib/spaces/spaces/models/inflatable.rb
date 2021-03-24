module Spaces
  module Inflatable

    def inflated; klass.new(inflatables) ;end
    def deflated; klass.new(deflatables) ;end

    def inflatables
      klass.inflatables.inject({}) { |m, i| m.tap { |m| m[i] = send(i) } }
    end

    def deflatables
      klass.inflatables.inject({}) { |m, i| m.tap { |m| m[i] = send(i) unless send(i) == defaults[i] } }
    end

  end
end
