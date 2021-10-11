module Providers
  module Docker
    class SystemPackages < ::Adapters::SystemPackages

      def snippets; klass.name ;end # TODO ... only temporary!

      def snippets_for(key)
        "RUN #{temporary_script_path}/#{qualifier}/#{key} #{division.send(key)&.join(' ')}"
      end

    end
  end
end
