module Packing
  class Pack < ::Resolving::Emission

    delegate(
      output_identifier: :image,
      adapter: :translator,
      [:configure_repositories, :clean_repository_configurations] => :adapter
    )

    alias_method :context_identifier, :identifier

    def copy_auxiliaries
      packs.copy_auxiliaries_for(self)
    end

    def remove_auxiliaries
      packs.remove_auxiliaries_for(self)
    end

    def translator = packs.translator_for(self)

  end
end
