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

    def encloses_commit?(identifier); encloses_good_result?(:commit, identifier) ;end
    def encloses_export?(identifier); encloses_good_result?(:export, identifier) ;end

    def encloses_good_result?(command, identifier)
      encloses_result?(command, identifier) && with_good_artifacts?(command, identifier)
    end

    def encloses_result?(command, identifier)
      Pathname.new("#{path_for(identifier)}/#{command}").exist?
    end

    def with_good_artifacts?(command, identifier)
      artifacts_by(command, identifier)&.any?(&:id)
    end

    def artifacts_by(command, identifier)
      Dir.chdir(path_for(identifier))
      YAML::load(Pathname.new("#{command}/artifacts.yaml").read)
    rescue Errno::ENOENT => e
      nil
    end

    def save(model)
      raise PackWithoutImagesError unless model.has?(:images)
      ensure_space_for(model)
      model.tap do |m|
        Pathname.new("#{path_for(model)}/commit.json").write(m.emit.to_h_deep.to_json)
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

    def unexecuted_anchors_for(command, model)
      unique_anchors_for(model).reject { |d| encloses_good_result?(command, d.identifier) }
    end

    def unique_anchors_for(model)
      model.binding_descriptors&.uniq(&:uniqueness) || []
    end

    protected

    def execute(command, model)
      raise PackWithoutImagesError unless model.has?(:images)
      save(model)
      Dir.chdir(path_for(model))
      bridge.build("#{command}.json").tap do |b|
        Pathname.new("#{command}").mkpath
        Pathname.new("#{command}/output.yaml").write(b.to_yaml)
        Pathname.new("#{command}/artifacts.yaml").write(b.artifacts.to_yaml)
      end
    rescue PackWithoutImagesError => e
      warn(error: e, command: command, identifier: model.identifier, klass: klass)
    ensure
      execute_on_anchors_for(command, model)
    end

    def execute_on_anchors_for(command, model)
      model.tap do |m|
        unexecuted_anchors_for(command, m).each { |d| execute(command, by(d)) }
      end
    end

    def bridge
      @bridge ||= Packer::Client.new
    end

  end

  class PackWithoutImagesError < StandardError
  end
end
