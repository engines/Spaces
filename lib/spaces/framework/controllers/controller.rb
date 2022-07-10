module Spaces
  module Controllers
    class Controller < ::Spaces::Model

      def control(args)
        log(args) #TODO: args should be vetted rather than defending against potential bugs
        instance_for(args).attempt
      end

      def instance_for(args) = instance_class.new(signature_for(**args))

      def instance_class = Control

      def signature_for(**args) =
        OpenStruct.new(
          klass: class_for(args[:action]),
          arguments: full_args_for(**args)
        )

      def full_args_for(**args) =
        default_args
        .merge(args_for(args[:action]))
        .merge(usable_args(args))

      def usable_args(args) = args.without(:action)

      def args_for(action) = array_for(action)[1] || {}

      def class_for(action) = array_for(action).first

      def array_for(action) =
        [action_command_map[action.to_sym]].flatten

      def action_command_map = {}

      def default_args = struct.to_h

      def initialize(**args)
        self.struct = struct_in_space(**args)
      end

      def struct_in_space(**args) =
        OpenStruct.new({space: space_identifier}.merge(args.symbolize_keys))

      def space_identifier = nil

      def log(args) #TODO: args should be vetted rather than defending against potential bugs
        logger.info("Arguments: #{args}")
      end

      def method_missing(m, **args, &block)
        (control(action: m, **args) if action_command_map.keys.include?(m)) || super
      end

      def respond_to_missing?(m, *)
        action_command_map.keys.include?(m) || super
      end

    end
  end
end
