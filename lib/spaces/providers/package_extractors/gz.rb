require_relative 'extractor'

module PackageExtractors
  class Gz < Extractor
    include ::Adapters::ScriptPaths

    delegate(
      [:qualifier, :environment_vars] => :state
    )

    def command =
      "#{temporary_script_path}/#{qualifier}/add #{environment_vars.in_quotes.join(' ')}"

  end
end
