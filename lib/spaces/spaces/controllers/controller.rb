module Spaces
  module Controllers
    class Controller < ::Spaces::Model

      def control(args, &block)
        instance_for(args, &block).attempt
      end

      def instance_for(args, &block)
        instance_class.new(signature_for(args), &block)
      end

      def instance_class; Control ;end

      def signature_for(**args)
        OpenStruct.new(
          klass: class_for(args[:action]),
          arguments: full_args_for(**args)
        )
      end

      def full_args_for(**args)
        default_args
        .merge(args_for(args[:action]))
        .merge(args.without(:action))
      end

      def args_for(action)
        array_for(action)[1] || {}
      end

      def class_for(action)
        array_for(action).first
      end

      def array_for(action)
        [action_command_map[action.to_sym]].flatten
      end

      def action_command_map; {} ;end

      def default_args; struct.to_h ;end

      def initialize(**args)
        self.struct = struct_in_space(**args)
      end

      def struct_in_space(**args)
        OpenStruct.new({space: space_identifier}.merge(args.symbolize_keys))
      end

      def space_identifier; ;end

      def method_missing(m, **args, &block)
        (control(action: m, **args, &block) if action_command_map.keys.include?(m)) || super
      end

      def respond_to_missing?(m, *)
        action_command_map.keys.include?(m) || super
      end

    end
  end
end
