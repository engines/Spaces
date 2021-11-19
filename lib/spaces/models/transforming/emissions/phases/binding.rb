module Emissions
  module Binding # NOW WHAT?

    def connected_blueprints
      connect_bindings.map(&:blueprint)
    end

    def target_identifiers; all_bindings.map(&:target_identifier) ;end

    def all_bindings; bindings_of_type(:all) ;end
    def connect_bindings; bindings_of_type(:connect) ;end
    def deep_bindings; bindings_of_type(:deep) ;end
    def deep_connect_bindings; bindings_of_type(:deep_connect) ;end
    def embed_bindings; bindings_of_type(:embed) ;end
    def deep_binder_bindings; bindings_of_type(:deep_binder) ;end

    def bindings_of_type(type)
      bindings.send("#{type}_bindings").uniq(&:uniqueness)
    end

  end
end
