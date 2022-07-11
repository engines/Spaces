module Targeting
  module Flattening

    def flattened
      empty.tap do |m|
        m.struct = struct.merge(flattened_struct)
      end
    end

    def flattened_struct
      OpenStruct.new.tap do |s|
        s.configuration = flattened_for(:configuration) if embed? && target_struct&.configuration
        s.service = flattened_for(:service) if target_struct&.service
      end
    end

    def flattened_for(key) =
      unresolved_struct.merge(target_struct[key]).merge(original(key))

    def original(key) = struct[key] || derived_features[key]

  end
end
