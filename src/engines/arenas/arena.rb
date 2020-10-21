module Arenas
  class Arena < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end

      def dns_class
        composition.divisions[:dns]
      end
    end

    delegate(
      [:dns_class, :provider_class] => :klass,
      [:arenas, :resolutions] => :universe
    )

    def emit
      super.tap { |m| m.identifier = struct.identifier }
    end

    def stanzas
      [divisions, providers].flatten.map(&:arena_stanzas).flatten.compact
    end

    def providers
      [all(:providers), providers_implied_in_containers].flatten.uniq(&:uniqueness)
    end

    def all(division_identifier)
      resolutions_with(division_identifier).map { |r| r.send(division_identifier).all }.flatten.compact
    end

    def resolutions_with(division_identifier)
      resolutions.all.select { |r| r.has?(division_identifier) }
    end

    def providers_implied_in_containers
      all(:containers).map do |c|
        provider_class.prototype(struct: c.struct, division: self)
      end
    end

    def provider_class; ::Divisions::Provider ;end

    def division_map
      @division_map ||=
        mandatory_keys.reduce({}) do |m, k|
          m.tap { m[k] = division_for(k) }
        end.compact
    end

    def initialize(struct: nil, identifier: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.identifier = identifier if identifier
    end

  end
end
