require_relative 'interface'

module Providers
  class AdaptingInterface < ::Spaces::Model
    include ::Spaces::Streaming

    relation_accessor :adapter
    relation_accessor :space

    delegate(
      [:artifacts, :emission] => :adapter,
      [:path_for] => :space
    )

    def save_artifacts
      artifacts.each do |a|
        artifact_path_for(a).write(a.content)
      end
    end

    def artifact_path_for(artifact); path_for(artifact.emission).join(artifact.filename) ;end

    def initialize(adapter, space = nil)
      self.adapter = adapter
      self.space = space
    end

  end
end
