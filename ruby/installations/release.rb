require_relative '../releases/release'

module Installations
  class Release < ::Releases::Release

    delegate(mandatory_keys: :schema)

    def division_map
      @installation_division_map ||= super.merge(
        mandatory_keys.reduce({}) do |m, k|
          m[k] = division_for(k)
          m
        end.compact
      )
    end

  end
end
