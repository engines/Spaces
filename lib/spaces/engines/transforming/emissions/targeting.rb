module Emissions
  module Targeting

    def deep_bindings; bindings_of_type(:deep) ;end
    def connect_bindings; bindings_of_type(:connect) ;end
    def embed_bindings; bindings_of_type(:embed) ;end

    def bindings_of_type(type)
      bindings.send("#{type}_bindings").uniq(&:uniqueness)
    end

  end
end
