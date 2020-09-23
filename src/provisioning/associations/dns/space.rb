module Dns
  class Space < ::Spaces::Subspace
    include Defaultables::Space

    class << self
      def default_model_class
        Dns
      end
    end

    def default_specific_class; PowerDns::PowerDns ;end

  end
end
