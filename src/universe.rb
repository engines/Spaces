require_relative 'spaces/models/space'
require_relative 'blueprinting/space'
require_relative 'resolving/space'
require_relative 'packing/space'
require_relative 'provisioning/space'
require_relative 'provisioning/associations/dns/space'

class Universe < ::Spaces::Space

  class << self
    def space_map
      @@space_map ||=
      {
        blueprints: Blueprinting::Space.new,
        resolutions: Resolving::Space.new,
        packing: Packing::Space.new,
        provisioning: Provisioning::Space.new,
        dns: Dns::Space.new
      }
    end
  end

  def path; "/opt/spaces/#{identifier}" ;end
  def host; 'spaces.internal' ;end

  def method_missing(m, *args, &block)
    klass.space_map[m] || super
  end

  def respond_to_missing?(m, *)
    klass.space_map[m] || super
  end

end
