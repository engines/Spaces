module Adapters
  module Terraform
    class Orchestration < ::Adapters::Orchestration

      #TODO: REFACTOR ... abstract up
      def artifact_qualifiers = [:capsule, :resources]

      def artifacts
        @artifacts ||= artifact_qualifiers.map do |q|
          send("#{q}_artifact")
        end.compact
      end

      def capsule_artifact
        artifact_class_for(:capsule)&.new(self) unless resourcer?
      end

      def resources_artifact
        artifact_class_for(:resources)&.new(self) if resolution.has?(:resources)
      end

    end
  end
end
