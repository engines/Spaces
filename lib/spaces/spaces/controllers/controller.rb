module Spaces
  module Controllers
    class Controller < ::Spaces::Model

      def control(with: [:run, :payload], **args, &block)
        with.reduce(command_for(args)) { |c, w| c.send(w, &block) }
      end

      def command_for(args)
        action_class_for(args[:command]).new(
          **default_args.
          merge(action_args_for(args[:command])).
          merge(args.without(:command))
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

    end
  end
end
