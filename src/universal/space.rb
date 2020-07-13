require_relative '../spaces/space'

module Universal
  class Space < ::Spaces::Space

    class << self
      def space_names
        [
          :blueprints,
          :resolutions,
          :terraform,
          :containers,
          :images,
          :providers
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

    def path; "/opt/spaces/#{identifier}" ;end
    def host; 'spaces.internal' ;end

    def method_missing(m, *args, &block)
      klass.space_map[m] || super
    end

    def respond_to_missing?(m, *)
      klass.space_map[m] || super
    end

  end
end
