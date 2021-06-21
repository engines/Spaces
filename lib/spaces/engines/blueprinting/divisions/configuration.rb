module Divisions
  class Configuration < ::Divisions::Division
    include ProviderDependent

    alias_method :original_embedded_with, :embedded_with

    include ::Packing::Division

    def embedded_with(other); original_embedded_with(other) ;end

    def packing_artifact_for(_); provider_aspect.packing_artifact ;end

    def inflated; self ;end
    def deflated; self ;end

    def keys; [:first] ;end

  end
end
