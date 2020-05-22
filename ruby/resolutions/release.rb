require_relative '../releases/release'

module Resolutions
  class Release < ::Releases::Release

    delegate(mandatory_keys: :schema)

    def division_map
      @resolution_division_map ||= super.merge(
        mandatory_keys.reduce({}) do |m, k|
          m[k] = division_for(k)
          m
        end.compact
      )
    end

  end
end
