module Emissions
  class PackingDivision < Division

    class << self
      def precedence; [:first, :early, :adds, :middle, :late, :removes, :last] ;end

      def precedence_midpoint; precedence.count / 2 ;end
    end

    delegate(
      [:precedence, :precedence_midpoint] => :klass,
      resolutions: :universe
    )

    def embed(other)
      tap do
        keys_including(other).each do |k|
          struct[k] = [other.struct[k], struct[k]].flatten.compact.uniq
        end
      end
    end

    def keys_including(other)
      by_precedence([other.keys, keys].flatten.uniq)
    end

    def packing_script_path
      resolutions.file_path_for("packing/scripts/#{qualifier}", context_identifier)
    end

    def keys; by_precedence(super) ;end

    def by_precedence(keys)
      keys.sort_by { |k| precedence.index(k) || precedence_midpoint }
    end

  end
end
