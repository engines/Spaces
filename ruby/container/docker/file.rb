require_relative '../tensor'
require_relative '../package'
require_relative 'collaboration'

module Container
  module Docker
    class File < ::Spaces::Product
      include Collaboration

      class << self
        def collaboration_precedence
          @@collaboration_precedence ||= [:dependencies, :environment, :domain, :framework, :docker_file ]
        end

        def step_precedence
          @@docker_file_step_precedence ||= [:initial, :packages, :permissions, :templates, :source_protection, :replacements, :seeds, :data_persistence, :installs, :source_persistence, :final]
        end
      end

      relation_accessor :tensor

      def content
        collaboration_precedence.map { |c| tensor.send(c).layers }.flatten.compact.join("\n")
      end

      def collaboration_precedence
        self.class.collaboration_precedence
      end

      def step_precedence
        self.class.step_precedence
      end

      def layers
        step_precedence.each { |s| require_relative "steps/#{s}" }
        super
      end

      def step_module_name
        "Container::Docker"
      end

      def file_path
        "#{identifier}/DockerFile"
      end

      def identifier
        tensor.struct.software.title
      end

      def descriptor
       tensor.descriptor
      end

      def initialize(tensor)
        self.tensor = tensor
      end

    end
  end
end
