module Spaces
  class Space < Model

    class << self
      def default_model_class = nil
    end

    delegate(default_model_class: :klass)

    def identifier = struct.identifier

    def space = itself

    def summaries = all.map(&:summary)

    def exist_then(identifiable, &block)
      yield(identifiable) if block_given? && exist?(identifiable)
    end

    def absent(array) = array.reject { |m| exist?(m) }

    def initialize(identifier:)
      self.struct = OpenStruct.new(identifier: identifier.to_sym)
    end

    protected

    def raise_lost_error(identifiable)
      raise ::Spaces::Errors::LostInSpace, {space: self.identifier, identifier: identifiable&.identifier}
    end

  end
end
