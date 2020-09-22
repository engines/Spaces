require_relative '../releases/release'

module Provisioning
  class Release < ::Releases::Release

    delegate(mandatory_keys: :composition)

    def emit
      super.tap { |m| m.descriptor = struct.descriptor }
    end

    def division_map
      @division_map ||=
        mandatory_keys.reduce({}) do |m, k|
          m.tap { m[k] = division_for(k) }
        end.compact
    end

  end
end
