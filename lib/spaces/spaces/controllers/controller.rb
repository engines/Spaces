module Spaces
  module Controllers
    class Controller < ::Spaces::Model

      def action(**args, &block)
        args[:threaded] ? control_thread(args, &block) : control(args, &block)
      end

      def control_thread(args, &block)
        args.tap { Thread.new { control(filing: true, **args, &block) } }
      end

      def control(args, &block)
        with.reduce(command_for(args)) { |c, w| c.send(w, &block) }
      end

      def command_for(args)
        action_class_for(args[:action]).new(**command_args_for(args))
      end

      def command_args_for(args)
        default_args
        .merge(action_args_for(args[:action]))
        .merge(args.without(:action))
      end

      def default_args; struct.to_h ;end

      def action_class_for(action)
        action_array_for(action).first
      end

      def action_args_for(action)
        action_array_for(action)[1] || {}
      end

      def action_array_for(action)
        [action_command_map[action.to_sym]].flatten
      end

      def action_command_map; {} ;end

      def initialize(**args)
        self.struct = OpenStruct.new(args.symbolize_keys)
      end

      def method_missing(m, **args, &block)
        control(command: m, **args, &block) if action_command_map.keys.include?(m)
      end

      def respond_to_missing?(m, *)
        action_command_map.keys.include?(m)
      end

      protected

      def struct_in_space(**args)
        OpenStruct.new({space: space_identifier}.merge(args.symbolize_keys))
      end

    end
  end
end
