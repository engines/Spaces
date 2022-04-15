module Divisions
  class Image < ::Divisions::Binding

    delegate(
      context_identifier: :division
    )

    def inflated; self ;end
    def deflated; self ;end

    def globalized
      super || empty.tap { |m| m.struct = struct.compact }
    end

    def output_identifier; "#{context_identifier.underscore}:#{default_tag}" ;end
    def default_tag; 'latest' ;end

  end
end
