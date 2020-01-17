require_relative 'requires'

module Container
  class Dependency
    class Variables < Docker::Step

      def content
        resolution.keys.map do |k|
          "ENV #{k} '#{resolution[k]}'"
        end
      end

      def resolution
        @resolution ||= context.dependency.resolution_for(context.overrides_for(context.struct.variables))
      end

    end
  end
end
