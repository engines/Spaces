require_relative 'requires'

class Universe < ::Spaces::Model

  class << self
    def space_map
      @@space_map ||=
      {
        publications: Publishing::Space.new,
        blueprints: Blueprinting::Space.new,
        resolutions: Resolving::Space.new,
        packs: Packing::Space.new,
        provisioning: Provisioning::Space.new,
        arenas: Arenas::Space.new,

        domains: Associations::Domains::Space.new,
        tenants: Associations::Tenants::Space.new
      }
    end
  end

  def path; workspace.join(identifier) ;end

  def workspace; Pathname(ENV['ENGINES_WORKSPACE'] || default_workspace) ;end
  def default_workspace; Pathname(ENV['TMP'] || '/tmp').join('spaces') ;end

  def host; 'spaces.internal' ;end

  def method_missing(m, *args, &block)
    klass.space_map[m] || super
  end

  def respond_to_missing?(m, *)
    klass.space_map[m] || super
  end

end
