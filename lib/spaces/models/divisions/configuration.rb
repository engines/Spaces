module Divisions
  class Configuration < ::Divisions::Division

    alias_method :original_embedded_with, :embedded_with

    def embedded_with(other); original_embedded_with(other) ;end

    def inflated; self ;end
    def deflated; self ;end

  end
end
