module Spaces
  module Inflatable

    def inflated; klass.new(inflatables) ;end
    def deflated; klass.new(deflatables) ;end

    def inflatables
      klass.features.inject({}) do |m, i|
        m.tap { |m| m[i] = send(i) }
      end
    end

    def deflatables
      klass.features.inject({}) do |m, i|
        m.tap { |m| m[i] = send(i) unless send(i) == derived_features[i] }
      end
    end

    protected

    def derived_features; {} ;end

  end
end
