require_relative 'snippets'

module Artifacts
  module Content
    include Snippets

    def text_content
      array_content.join("\n")
    end

    def yaml_content
      YAML.dump(hash_content.no_symbols)
    end

    def hash_content
      [snippets].flatten.inject({}) do |m, s|
        m.merge(s)
      end
    end

    def array_content
      [snippets].flatten.values
    end

  end
end
