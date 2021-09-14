module Spaces
  module Controllers
    class Controller < ::Spaces::Model

      def control(args, &block)
        log_control(args, &block)
        args[:threaded] ? _control_with_threading(args, &block) : _control(args, &block)
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
        control(action: m, **args, &block) if action_command_map.keys.include?(m)
      end

      def respond_to_missing?(m, *)
        action_command_map.keys.include?(m)
      end

      protected

      def _control_with_threading(args, &block)
        (Thread.new { _control(args, &block) }).join
      end

      def _control(with: [:run, :payload], **args, &block)
        with.reduce(command_for(args)) { |c, w| c.send(w, &block) }
      end

      def struct_in_space(**args)
        OpenStruct.new({space: space_identifier}.merge(args.symbolize_keys))
      end

      def log_control(args, &block)
        logger.info("Controller command: #{args} #{block_given? ? block : 'Block not given'}")
      end

    end
  end
end
