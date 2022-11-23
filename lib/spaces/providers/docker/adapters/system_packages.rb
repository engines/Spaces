module Adapters
  module Docker
    class SystemPackages < ::Adapters::SystemPackages

      def snippets_for(key) =
        "RUN #{temporary_script_path}/#{qualifier}/#{key} #{send(key)&.join(' ')}"

    end
  end
end
