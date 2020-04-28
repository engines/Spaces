require_relative '../spaces/space'

module Universal
  class Space < ::Spaces::Space

    class << self
      def space_names
        [
          :containers,
          :images,
          :volumes,
          :docker,
          :projects,
          :installations,
          :frameworks,
          :web_servers,
          :nodules,
          :environments,
          :domains,
          :users,
        ]
      end

      def space_map
        @@space_map ||= space_names.inject({}) do |m, i|
          require_relative "../#{i}/space"
          m[i] = Module.const_get("#{i.to_s.camelize}::Space").new
          m
        end
      end
    end

    define_method (:blueprints) { projects }
    define_method (:path) { "/opt/engines/#{identifier}" }
    define_method (:host) { 'engines.internal' }

    def method_missing(m, *args, &block)
      klass.space_map[m] || super
    end

  end
end
