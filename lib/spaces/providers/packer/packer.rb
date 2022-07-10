require 'packer'

module Providers
  module Packer
    class Packer < ::Providers::Provider

      # alias_method :pack, :emission

      def save
        path_for(pack).join("commit.json").write(pack.artifact.to_json)
      end

      def export = execute(:export)
      def commit = execute(:commit)

      def push = nil
      def fix = nil
      # def inspect(model) ;end
      def validate  = nil

      def encloses_commit? = encloses_good_result?(:commit)
      def encloses_export? = encloses_good_result?(:export)

      def encloses_good_result?(command) =
        encloses_result?(command) && with_good_artifacts?(command)

      def encloses_result?(command) =
        path_for(pack).join(command.to_s).exist?

      def with_good_artifacts?(command) =
        artifacts_by(command)&.any?(&:id)

      def artifacts_by(command)
        YAML::load(path_for(pack).join("#{command}", 'artifacts.yaml').read)
      rescue Errno::ENOENT => e
        nil
      end

      protected

      def execute(command)
        raise ::Packing::Errors::NoImage, "Model doesn't have images: #{pack.identifier}" unless pack.has?(:builders)
        space.save(pack)

        Dir.chdir(path_for(pack).to_path) do
          Pathname.new("#{command}").mkpath

          bridge.build("#{command}.json").tap do |b|
            Pathname.new("#{command}/output.yaml").write(b.to_yaml)
            Pathname.new("#{command}/artifacts.yaml").write(b.artifacts.to_yaml)
          end
        end
      ensure
        execute_on_connections_for(command)
      end

      def bridge
        @bridge ||= ::Packer::Client.new
      end

      private

      def execute_on_connections_for(command)
        pack.tap do
          unexecuted_aspects_for(command).each { |a| a.execute(command) }
        end
      end

      def unexecuted_aspects_for(command) =
        unique_aspects.reject { |a| a.encloses_good_result?(command) }

      def unique_aspects =
        unique_connections.map { |c| klass.new(by(c.resolution_identifier), space) }.compact

      def unique_connections = pack.connect_bindings.uniq(&:uniqueness)

    end
  end
end
