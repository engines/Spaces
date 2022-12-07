module Artifacts
  module Content

    def text_content = array_content.join("\n")

    def yaml_content = YAML.dump(hash_content.no_symbols)
    def json_content = hash_content.no_symbols.to_json

    def hash_content
      [snippets].flatten.inject({}) do |m, s|
        m.merge(s)
      end
    end

    def array_content = [snippets].flatten.values

  end
end
