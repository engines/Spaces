module Arenas
  class Arena < ::Emissions::Emission

    class << self
      def composition_class = Composition
      def provider_class = ::Divisions::Provider

      def dns_class = composition.divisions[:dns]
    end

    delegate(
      [:dns_class, :provider_class] => :klass,
      [:arenas, :resolutions] => :universe
    )

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

    def arena = itself

    def division_map
      @division_map ||=
        mandatory_keys.reduce({}) do |m, k|
          m.tap { m[k] = division_for(k) }
        end.compact
    end

    def initialize(struct: nil, identifier: nil)
      super(struct: struct)
      self.struct.identifier = identifier if identifier
    end

  end
end
