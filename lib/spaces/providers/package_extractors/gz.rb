require_relative 'extractor'

module PackageExtractors
  class Gz < Extractor
    include ::Adapters::ScriptPaths

    delegate(
      [:qualifier, :division] => :adapter,
      environment_vars: :division
    )

    def extraction
      struct.extraction ||= derived_features[:extraction]
    end

    def extracted_path
      struct.extracted_path ||= derived_features[:extracted_path]
    end

    def command =
      "#{temporary_script_path}/#{qualifier}/add #{environment_vars.in_quotes.join(' ')}"

  end
end
