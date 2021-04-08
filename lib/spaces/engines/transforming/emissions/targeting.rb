module Emissions
  module Targeting

    def turtle_targets; targets(:turtle_targets) ;end
    def connect_targets; targets(:connect_targets) ;end
    def embed_targets; targets(:embed_targets) ;end

    def targets(type)
      bindings.send(type).uniq(&:uniqueness)
    end

  end
end
