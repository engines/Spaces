module Adapters
  module Docker
    class BundledPackage < ::Adapters::BundledPackage

     def snippets =
        "RUN #{temporary_script_path}/#{qualifier}/add #{environment_vars.in_quotes.join(' ')}"

    end
  end
end
