require_relative '../dns'

module Dns
  module PowerDns
    class PowerDns < Dns

      class << self
        def inheritance_paths; __dir__ ;end
      end

      require_files_in :stanzas

      def ttl; 120 ;end
      def server_url; 'http://[fd61:d025:74d7:f46a::ffff]:8081/api/v1' ;end
      def api_key; '369db357c9599dbee19400aaf1d14f98a5e8bb902f3c69a271f0cbacecb1126f' ;end

    end
  end
end
