require_relative '../spaces/product'
require_relative '../blueprint/tensor'
require_relative '../software/package'
require_relative 'file/collaboration'

module Docker
  class File < ::Spaces::Product
    include Collaboration

    Dir["#{__dir__}/file/steps/*"].each { |f| require f }

    class << self
      def collaboration_precedence
        @@collaboration_precedence ||= [:framework, :environment, :domain, :dependencies, :docker_file]
      end

      def step_group_precedence
        @@step_group_precedence ||= [:first, :early, :anywhere, :late, :last]
      end

      def step_precedence
        @@docker_file_step_precedence ||= {
          late: [:preparations, :permissions, :templates, :source_protection, :replacements, :seeds, :data_persistence, :installs, :source_persistence],
          last: [:final]
        }
      end

      def script_collaborators
        @@docker_file_script_collaborators ||= [:software]
      end
    end

    def collaboration_precedence
      self.class.collaboration_precedence
    end

    def script_collaborators
      self.class.script_collaborators
    end

    def step_group_precedence
      self.class.step_group_precedence
    end

    def scripts
      script_collaborators.map { |c| tensor.send(c).scripts }.flatten.compact
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

  end
end
