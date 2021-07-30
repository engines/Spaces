module Spaces
  module Controllers
    class Controller < ::Spaces::Model

      def control(method, with: [:run, :payload], **args)
        with.reduce(command_for(method, **args)) { |c, w| c.send(w) }
      end

      def command_for(method, **args)
        method_class_for(method).new(
          default_args.
          merge(method_args_for(method)).
          merge(args)
        )
      end

      def default_args; struct.to_h ;end

      def method_class_for(method)
        method_array_for(method).first
      end

      def method_args_for(method)
        method_array_for(method)[1] || {}
      end

      def method_array_for(method)
        [method_class_map[method]].flatten
      end

      def method_class_map; {} ;end

      def initialize(**args)
        self.struct = OpenStruct.new(args.symbolize_keys)
      end

      # def method_missing(m, *args, &block)
      #   command_for(m, *args) if respond_to_missing?(m)
      # end
      #
      # def respond_to_missing?(m, *)
      #   method_class_map.keys.include?(m)
      # end

    end
  end
end
