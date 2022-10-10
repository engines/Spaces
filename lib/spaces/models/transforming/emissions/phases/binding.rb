module Emissions
  module Binding

    def connected_blueprints =connect_bindings.map(&:blueprint)

    def target_identifiers = all_bindings.map(&:target_identifier)

    def all_bindings = bindings_of_type(:all)
    def connect_bindings = bindings_of_type(:connect)
    def deep_bindings = bindings_of_type(:deep)
    def deep_connect_bindings = bindings_of_type(:deep_connect)
    def embed_bindings = bindings_of_type(:embed)
    def deep_binder_bindings = bindings_of_type(:deep_binder)

    def bindings_of_type(type) =
      bindings.send("#{type}_bindings").uniq(&:uniqueness)

  end
end
