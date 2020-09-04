require_relative '../spaces/schema'
require_relative '../service_networking/service_network'
require_relative '../dns/dns'

module Provisioning
  class Schema < ::Spaces::Schema

    class << self
      def associative_classes
        [
          ServiceNetworking::ServiceNetwork,
          Dns::Dns
        ]
      end

      def divisions; @divisions ||= map_for(associative_classes) ;end

      def mandatory_keys; divisions.keys ;end
    end

    delegate(mandatory_keys: :klass)

  end
end
