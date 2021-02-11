module Arenas
  class Arena < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
      def provider_class; ::Divisions::Provider ;end

      def dns_class
        composition.divisions[:dns]
      end
    end

    delegate(
      [:dns_class, :provider_class] => :klass,
      arenas: :universe
    )

    def resolutions
      @resolutions ||=
      universe.resolutions.identifiers(arena_identifier: identifier).map do |i|
        universe.resolutions.by(i)
      end
    end

    def resolutions_with(division_identifier)
      resolutions.select { |r| r.has?(division_identifier) }
    end

    def stanzas_content
      %( #{providers_required}
	     #{[associations, providers].flatten.map(&:arena_stanzas).flatten.compact.join}
       )
    end

    def providers
      [all(:providers), providers_implied_in_containers].flatten.uniq(&:uniqueness)
    end

    def providers_required
     %(required_providers { 
	         #{[providers].flatten.map(&:providers_require).flatten.compact.join}
}
      )
    end


    def all(division_identifier)
      resolutions_with(division_identifier).map { |r| r.send(division_identifier).all }.flatten.compact
    end

    def providers_implied_in_containers
      all(:containers).map do |c|
        provider_class.prototype(struct: c.struct, division: self)
      end
    end

    def arena; itself ;end

  end
end
