require 'packer'

module Packing
  class Space < ::Spaces::Space

    class << self
      def default_model_class; Pack ;end
    end

    delegate(resolutions: :universe)

    def by(identifier, klass = default_model_class)
      by_json(identifier, klass)
    rescue Errno::ENOENT => e
      warn(error: e, identifier: identifier, klass: klass)

      klass.new(resolutions.by(identifier)).tap do |m|
        save(m)
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
      YAML::load(path_for(descriptor).join(command, "artifacts.yaml").read)
    rescue Errno::ENOENT => e
      nil
    end

    def save(model)
      raise PackWithoutImagesError, "Model doesn't have images: #{model.identifier}" unless model.has?(:images)
      ensure_space_for(model)

      model.tap do |m|
        path_for(model).join("commit.json").write(m.emit.to_h_deep.to_json)
      end

      model.identifier
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

    def execute(command, model)
      raise PackWithoutImagesError, "Model doesn't have images: #{model.identifier}" unless model.has?(:images)
      save(model)

      cmd_path = sym_to_pathname(command)

      Dir.chdir(path_for(model).to_path) do
        cmd_path.mkpath

        bridge.build("#{command}.json").tap do |b|
          cmd_path.join("output.yaml").write(b.to_yaml)
          cmd_path.join("artifacts.yaml").write(b.artifacts.to_yaml)
        end
      end
    rescue PackWithoutImagesError => e
      warn(error: e, command: command, identifier: model.identifier, klass: klass)
    ensure
      execute_on_anchors_for(cmd_path, model)
    end

    def bridge
      @bridge ||= Packer::Client.new
    end

    private

    def execute_on_anchors_for(command, model)
      model.tap do
        unexecuted_anchors_for(command, model).each { |d| execute(command, by(d.identifier)) }
      end
    end

    def unexecuted_anchors_for(command, model)
      unique_anchors_for(model).reject { |d| encloses_good_result?(command, d) }
    end

    def unique_anchors_for(model)
      model.connecting_descriptors&.uniq(&:uniqueness) || []
    end

  end

  class PackWithoutImagesError < StandardError
  end
end
