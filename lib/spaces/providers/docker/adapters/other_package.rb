module Adapters
  module Docker
    class OtherPackage < ::Adapters::OtherPackage

     def snippets
        "RUN #{temporary_script_path}/#{qualifier}/add #{environment_vars.in_quotes.join(' ')}"
      end

    end
  end
end
