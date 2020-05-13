require_relative '../projects/collaboration'

module Installations
  class Collaboration < ::Projects::Collaboration

    delegate(mandatory_keys: :schema)

    def collaborator_map
      @installation_collaborator_map ||= super.merge(
        mandatory_keys.reduce({}) do |m, k|
          m[k] = protoype_for(k)
          m
        end.compact
      )
    end

  end
end
