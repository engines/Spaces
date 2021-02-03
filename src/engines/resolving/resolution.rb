require_relative 'packing'

module Resolving
  class Resolution < ::Emissions::Emission
    include Resolving::Packing

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      resolutions: :universe,
      blueprints: :resolutions
    )

    relation_accessor :arena

    alias_accessor :blueprint, :predecessor

    def complete?
      all_complete?(divisions)
    end

    def embeds_including_blueprint; [blueprint, embeds].flatten.compact.reverse ;end

    def content_into(directory, source:)
      resolutions.file_names_for(directory, source.context_identifier).map do |t|
        Interpolating::FileText.new(origin: t, directory: directory, transformable: self)
      end
    end

    def empty; super.tap { |m| m.arena = arena } ;end

  end
end
