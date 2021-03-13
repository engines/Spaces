require 'packer'

module Packing
  class Space < ::Spaces::Space

    class << self
      def default_model_class; Pack ;end
    end

    delegate(resolutions: :universe)

    def identifiers(arena_identifier: '*', resolution_identifier: '*')
      path.glob("#{arena_identifier}/#{resolution_identifier}").map do |p|
        "#{p.relative_path_from(path)}"
      end
    end

    def by(identifier, klass = default_model_class)
      super.tap do |m|
        m.resolution = resolutions.by(identifier)
      end
    end

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

    def save(model)
      raise PackWithoutImagesError, "Model doesn't have images: #{model.identifier}" unless model.has?(:builders)

      ensure_connections_exist_for(model)
      super.tap do
        path_for(model).join('commit.json').write(model.to_h.to_json)
      end
    rescue PackWithoutImagesError => e
      warn(error: e, identifier: model.identifier, klass: klass)
    end

    def export(model); execute(:export, model) ;end
    def commit(model); execute(:commit, model) ;end

    def push(model) ;end
    def fix(model) ;end
    # def inspect(model) ;end
    def validate(model) ;end

    protected

    def ensure_connections_exist_for(model)
      model.connections_packed.each { |p| save(p) }
    end

    def execute(command, model)
      raise PackWithoutImagesError, "Model doesn't have images: #{model.identifier}" unless model.has?(:builders)
      save(model)

      Dir.chdir(path_for(model).to_path) do
        Pathname.new("#{command}").mkpath

        bridge.build("#{command}.json").tap do |b|
          Pathname.new("#{command}/output.yaml").write(b.to_yaml)
          Pathname.new("#{command}/artifacts.yaml").write(b.artifacts.to_yaml)
        end
      end
    rescue PackWithoutImagesError => e
      warn(error: e, command: command, identifier: model.identifier, klass: klass)
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
      model.connect_targets.uniq(&:uniqueness) || []
    end

  end

  class PackWithoutImagesError < StandardError
  end
end
