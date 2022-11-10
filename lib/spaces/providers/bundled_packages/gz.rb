module Adapters
  module Gz
    class BundledPackage < ::Adapters::BundledPackage

      def command =
        "#{temporary_script_path}/#{qualifier}/add #{environment_vars.in_quotes.join(' ')}"

    end
  end
end
