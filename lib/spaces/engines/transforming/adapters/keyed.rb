require_relative 'precedence'

module Adapters
  class Keyed < Adapter

    def snippet_map
      @snippet_map ||= keys.inject({}) do |m, k|
        m.tap do
          m[k] = snippets_for(k)
        end
      end
    end

    def keys; to_h.keys ;end
    def to_h; @to_h ||= division.struct.to_h ;end

  end
end
