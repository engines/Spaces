require_relative '../tensor'
require_relative '../package'
require_relative 'collaboration'

module Container
  module Docker
    class File < ::Spaces::Product
      include Collaboration

      Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def collaboration_precedence
          @@collaboration_precedence ||= [:framework, :environment, :domain, :dependencies, :docker_file]
        end

        def step_group_precedence
          @@step_group_precedence ||= [:first, :early, :anywhere, :late, :last]
        end

        def step_precedence
          @@docker_file_step_precedence ||= {
            late: [:preparations, :packages, :permissions, :templates, :source_protection, :replacements, :seeds, :data_persistence, :installs, :source_persistence],
            last: [:final]
          }
        end
      end

      relation_accessor :tensor

      def collaboration_precedence
        self.class.collaboration_precedence
      end

      def step_group_precedence
        self.class.step_group_precedence
      end

      def content
        layers.flatten.compact.join("\n")
      end

      def layers
        step_group_precedence.map do |g|
          collaboration_precedence.map do |c|
            tensor.send(c).layers_for(g)
          end
        end
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
