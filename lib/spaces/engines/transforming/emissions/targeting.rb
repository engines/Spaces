module Emissions
  module Targeting

    def all_bindings; bindings_of_type(:all) ;end
    def connect_bindings; bindings_of_type(:connect) ;end
    def deep_bindings; bindings_of_type(:deep) ;end
    def embed_bindings; bindings_of_type(:embed) ;end

    def bindings_of_type(type)
      bindings.send("#{type}_bindings").uniq(&:uniqueness)
    end

  end
end
