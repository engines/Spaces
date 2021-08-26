class Universe < ::Spaces::Model

  class << self
    def space_map
      @@space_map ||=
        space_array.inject({}) do |m, s|
          m.tap { |m| m[s.identifier] = s }
        end
    end

    def space_array
      @@space_array ||=
      [
        Publishing::Space.new(:publications),
        Locating::Space.new(:locations),
        Blueprinting::Space.new(:blueprints),
        Installing::Space.new(:installations),
        Resolving::Space.new(:resolutions),
        Registry::Space.new(:registry),
        Packing::Space.new(:packs),
        Provisioning::Space.new(:provisioning),
        Arenas::Space.new(:arenas),
        Keys::Space.new(:user_keys),

        Associations::Domains::Space.new(:domains),
        Associations::Tenants::Space.new(:tenants)
      ]
    end
  end

  def path; workspace.join(identifier) ;end

  def workspace; Pathname(ENV['ENGINES_WORKSPACE'] || default_workspace) ;end
  def default_workspace; Pathname(ENV['TMP'] || '/tmp').join('spaces') ;end

  def host; 'spaces.internal' ;end

  def method_missing(m, *args, &block)
    klass.space_map[m] || (raise ::Spaces::Errors::NoSpace, {identifier: m})
  end

  def respond_to_missing?(m, *)
    klass.space_map[m]
  end

end
