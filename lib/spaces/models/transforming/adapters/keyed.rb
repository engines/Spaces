module Adapters
  module Keyed

    def snippet_map
      @snippet_map ||= adapter_keys.inject({}) do |m, k|
        m.tap do
          m[k] = snippets_for(k)
        end
      end
    end

    def adapter_keys = to_h.keys

    def to_h
      @to_h ||= division.struct.to_h
    end

  end
end
