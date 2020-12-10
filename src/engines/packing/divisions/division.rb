module Packing
  module Division

    def precedence; [:first, :early, :adds, :middle, :late, :removes, :last] ;end

    def precedence_midpoint; precedence.count / 2 ;end

    def embed(other)
      return other if struct.empty?

      tap do
        keys_including(other).each do |k|
          struct[k] = [other.struct[k], struct[k]].flatten.compact.uniq
        end
      end
    end

    def keys_including(other)
      by_precedence([other.keys, keys].flatten.uniq)
    end

    def packing_source_path
      resolutions.file_path_for(:packing, context_identifier)
    end

    def temporary_packing_path
      "tmp/scripts/#{qualifier}"
    end

    def keys; by_precedence(super) ;end

    def by_precedence(keys)
      keys.sort_by { |k| precedence.index(k) || precedence_midpoint }
    end

  end
end
