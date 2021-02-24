module Arenas
  module Bootstrapping

    def bootstrapped_with(blueprint_identifier)
      duplicate(self).tap do |m|
        m.struct.tap do |s|
          s.bindings = bootstrap_merged_for(blueprint_identifier)
        end
      end
    end

    def bootstrap_merged_for(blueprint_identifier)
      [bootstrap_for(blueprint_identifier), struct[:bindings]].compact.flatten.uniq
    end

    def bootstrap_for(blueprint_identifier)
      OpenStruct.new(
        type: 'embed',
        target: {
          identifier: blueprint_identifier
        }
      )
    end

  end
end
