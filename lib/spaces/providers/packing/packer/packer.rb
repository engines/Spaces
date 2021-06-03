require 'packer'

module Providers
  class Packer < ::ProviderAspects::Provider

    alias_method :pack, :emission

    def export; execute(:export) ;end
    def commit; execute(:commit) ;end

    def push ;end
    def fix ;end
    # def inspect(model) ;end
    def validate ;end

    def encloses_commit?; encloses_good_result?(:commit) ;end
    def encloses_export?; encloses_good_result?(:export) ;end

    def encloses_good_result?(command)
      encloses_result?(command) && with_good_artifacts?(command)
    end

    def encloses_result?(command)
      path_for(pack).join(command.to_s).exist?
    end

    def with_good_artifacts?(command)
      artifacts_by(command)&.any?(&:id)
    end

    def artifacts_by(command)
      YAML::load(path_for(pack).join("#{command}", 'artifacts.yaml').read)
    rescue Errno::ENOENT => e
      nil
    end

    protected

    def execute(command)
      raise ::Packing::Errors::NoImage, "Model doesn't have images: #{pack.identifier}" unless pack.has?(:builders)
      save(pack)

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

    def unexecuted_aspects_for(command)
      unique_aspects.reject { |a| a.encloses_good_result?(command) }
    end

    def unique_aspects
      unique_connections.map { |c| klass.new(by(c.resolution_identifier), space) }.compact
    end

    def unique_connections
      pack.connect_bindings.uniq(&:uniqueness)
    end

  end
end
