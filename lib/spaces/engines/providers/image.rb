require_relative 'provider_aspect'

module Providers
  class Image < ProviderAspect

    # PACKER-SPECIFIC
    def post_processor_artifacts; end

  end
end
