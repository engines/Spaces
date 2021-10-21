module Spaces
  module Inflatable

    def inflated; klass.new(inflatables) ;end
    def deflated; klass.new(deflatables) ;end

    def inflatables
      features.inject({}) do |m, i|
        m.tap { |m| m[i] = send(i) }
      end
    end

    def deflatables
      features.inject({}) do |m, i|
        m.tap { |m| m[i] = send(i) unless send(i) == derived_features[i] }
      end
    end

    def features; klass.features ;end

    protected

    def derived_features; {} ;end

  end
end
