require_relative 'requires'

module Container
  class Dependent
    class Variables < Docker::Step

      def content
        resolution.keys.map do |k|
          "ENV #{context.descriptor.identifier}_#{k} '#{resolution[k]}'"
        end
      end

      def resolution
        @resolution ||= context.dependency.resolution_for(context.overrides_for(context.struct.variables))
      end

    end
  end
end
