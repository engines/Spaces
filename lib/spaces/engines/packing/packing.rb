require 'packer'

# PACKER-SPECIFIC
module Packing
  module Packing

    def export(model); execute(:export, model) ;end
    def commit(model); execute(:commit, model) ;end

    def push(model) ;end
    def fix(model) ;end
    # def inspect(model) ;end
    def validate(model) ;end

    def encloses_commit?(descriptor); encloses_good_result?(:commit, descriptor) ;end
    def encloses_export?(descriptor); encloses_good_result?(:export, descriptor) ;end

    def encloses_good_result?(command, descriptor)
      encloses_result?(command, descriptor) && with_good_artifacts?(command, descriptor)
    end

    def encloses_result?(command, descriptor)
      path_for(descriptor).join(command.to_s).exist?
    end

    def with_good_artifacts?(command, descriptor)
      artifacts_by(command, descriptor)&.any?(&:id)
    end

    def artifacts_by(command, descriptor)
      YAML::load(path_for(descriptor).join("#{command}", 'artifacts.yaml').read)
    rescue Errno::ENOENT => e
      nil
    end

    protected

    def execute(command, model)
      raise ::Packing::Errors::NoImage, "Model doesn't have images: #{model.identifier}" unless model.has?(:builders)
      save(model)

      Dir.chdir(path_for(model).to_path) do
        Pathname.new("#{command}").mkpath

        bridge.build("#{command}.json").tap do |b|
          Pathname.new("#{command}/output.yaml").write(b.to_yaml)
          Pathname.new("#{command}/artifacts.yaml").write(b.artifacts.to_yaml)
        end
      end
    ensure
      execute_on_connections_for(command, model)
    end

    def bridge
      @bridge ||= Packer::Client.new
    end

    private

    def execute_on_connections_for(command, model)
      model.tap do
        unexecuted_connections_for(command, model).each { |t| execute(command, by(t.resolution.identifier)) }
      end
    end

    def unexecuted_connections_for(command, model)
      unique_connections_for(model).reject { |t| encloses_good_result?(command, t) }
    end

    def unique_connections_for(model)
      model.connect_bindings.uniq(&:uniqueness)
    end

  end
end
