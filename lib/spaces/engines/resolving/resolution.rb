require_relative 'flattening'
require_relative 'packing'
require_relative 'provisioning'
require_relative 'status'

module Resolving
  class Resolution < ::Settling::Settlement
    include Resolving::Flattening
    include Resolving::Packing
    include Resolving::Provisioning
    include Resolving::Status

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:runtime_binding, :packing_binding] => :arena,
      [:installations, :packs, :provisioning] => :universe,
      input: :installation
    )

    def installation; @installation ||= installations.by(identifier) ;end

    def complete?
      all_complete?(divisions)
    end

    def connections_settled
      super { |c| c.with_embeds.resolution_in(arena) }
    end

    def embeds_including_blueprint; [blueprint, embeds_down].flatten.compact.reverse ;end

    def content_into(directory, source:)
      resolutions.file_names_for(directory, source.context_identifier).map do |t|
        Interpolating::FileText.new(origin: t, directory: directory, transformable: self)
      end
    end

  end
end
