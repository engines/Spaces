require_relative 'model'
require_relative 'paths'
require_relative 'reading'
require_relative 'saving'
require_relative 'deleting'
require_relative 'topology'

module Spaces
  class Space < Model
    include ::Spaces::Paths
    include ::Spaces::Reading
    include ::Spaces::Saving
    include ::Spaces::Deleting
    include ::Spaces::Topology

    class << self
      def universe
        @@universe ||= Universe.new
      end

      def default_model_class ;end
    end

    delegate([:universe, :default_model_class] => :klass)

    def identifier; struct.identifier ;end

    def ensure_space
      path.mkpath
    end

    def summaries
      all.map(&:summary)
    end

    def all
      identifiers.map { |i| by(i) }
    end

    def simple_identifiers(*_)
      path.glob('*').map { |p| p.basename.to_s }
    end

    def identifiers(arena_identifier: '*', blueprint_identifier: '*')
      path.glob("#{arena_identifier}/#{blueprint_identifier}").map do |p|
        "#{p.relative_path_from(path)}".as_compound
      end
    end

    def exist?(identifiable)
      identifiable && path_for(identifiable).exist?
    end

    def exist_then(identifiable, &block)
      yield(identifiable) if block_given? && exist?(identifiable)
    end

    def absent(array)
      array.reject { |m| exist?(m) }
    end

    def initialize(identifier)
      self.struct = OpenStruct.new(identifier: identifier.to_sym)
    end

    protected

    def raise_lost_error(identifiable)
      raise ::Spaces::Errors::LostInSpace, {space: self.identifier, identifier: identifiable&.identifier}
    end

  end
end
