module Spaces
  module Controllers
    class Controller < ::Spaces::Model

      def control(action, with: [:run, :payload], **args)
        with.reduce(command_for(action, **args)) { |c, w| c.send(w) }
      end

      def command_for(action, **args)
        action_class_for(action).new(
          **default_args.
          merge(action_args_for(action)).
          merge(args)
        )
      end

      def default_args; struct.to_h ;end

      def action_class_for(action)
        action_array_for(action).first
      end

      def action_args_for(action)
        action_array_for(action)[1] || {}
      end

      def action_array_for(action)
        [action_command_map[action]].flatten
      end

      def action_command_map; {} ;end

      def initialize(**args)
        self.struct = OpenStruct.new(args.symbolize_keys)
      end

      def method_missing(m, *args, &block)
        control(m, *args) if respond_to_missing?(m)
      end

      def respond_to_missing?(m, *)
        action_command_map.keys.include?(m)
      end

    end
  end
end
