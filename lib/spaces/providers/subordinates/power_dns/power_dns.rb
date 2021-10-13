module Providers
  module PowerDns
    class PowerDns < ::Providers::Provider

      def dns_address; "#{container_type}.#{blueprint_identifier}.ipv4_address" ;end

      def container_address_for(resolution); "#{container_type}.#{resolution.blueprint_identifier}.ipv6_address" ;end

      def protocol; configuration.struct.protocol || 'http' ;end
      def port; configuration.struct.port || 8081 ;end
      def endpoint; configuration.struct.endpoint ;end

    end
  end
end
