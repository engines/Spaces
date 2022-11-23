require_relative 'extractor'

module Packaging
  class Gz < Extractor
    include ::Adapters::ScriptPaths

    class << self
      def system_dependencies = [:unzip]
    end

    delegate(
      [:qualifier, :environment_vars] => :state
    )

    def command =
      "#{temporary_script_path}/#{qualifier}/add #{environment_vars.in_quotes.join(' ')}"

  end
end
