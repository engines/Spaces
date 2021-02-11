require_relative 'division'

module Emissions
  class Divisible < Division

    class << self
      def subdivision_class
        Module.const_get(name.singularize)
      end

      def default_struct; [] ;end
    end

    delegate(subdivision_class: :klass)

    def related_divisions
      @related_divisions ||= emission.divisions
    end
    def arena_stanzas; all.map(&:arena_stanzas) ;end
    def providers_required; all.map(&:providers_required) ;end #test
    def provisioning_stanzas; all.map(&:provisioning_stanzas) ;end

    def all
      @all ||= struct&.map { |s| subdivision_for(s) }&.compact || []
    end

    def subdivision_for(struct)
      subdivision_class.new(struct: struct, division: self)
    rescue NameError => _
      struct
    rescue ArgumentError => e
      warn(error: e, klass: self.class, blueprint: context_identifier, content: struct.to_h_deep)
      nil
    end

    def resolved
      empty.tap { |d| d.struct = all.map(&:resolved).map(&:struct) }
    end

    def struct_with(other); [struct, other.struct].flatten.uniq ;end

    def initialize(struct: nil, emission: nil, label: nil)
      check_subdivision_class
      super
    end

    def check_subdivision_class
      subdivision_class
    rescue NameError => e
      warn(error: e, klass: klass.name.singularize, verbosity: [:silence])
    end

  end
end
