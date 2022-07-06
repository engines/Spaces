module Divisions
  class Image < ::Divisions::Binding

    delegate(
      context_identifier: :division
    )

    def inflated = self
    def deflated = self

    def globalized = super || empty.tap { |m| m.struct = struct.compact }

    def output_identifier = context_identifier.underscore

  end
end
