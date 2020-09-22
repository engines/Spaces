require 'packer'
require_relative '../spaces/space'
require_relative 'images/space'

module Packing
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Pack
      end
    end

    delegate(resolutions: :universe)

    def by(descriptor, klass = default_model_class)
      by_json(descriptor, klass)
    rescue Errno::ENOENT => e
      warn(error: e, descriptor: descriptor, klass: klass)
      klass.new(resolutions.by(descriptor)).tap do |m|
        save(m)
      end
    end

    def images; @images ||= Images::Space.new ;end

    def encloses_commit?(descriptor); encloses_good_result?(:commit, descriptor) ;end
    def encloses_export?(descriptor); encloses_good_result?(:export, descriptor) ;end

    def encloses_good_result?(command, descriptor)
      encloses_result?(command, descriptor) && with_good_artifacts?(command, descriptor)
    end

    def encloses_result?(command, descriptor)
      Dir.exist?("#{path_for(descriptor)}/#{command}")
    end

    def with_good_artifacts?(command, descriptor)
      artifacts_by(command, descriptor)&.any?(&:id)
    end

    def artifacts_by(command, descriptor)
      Dir.chdir(path_for(descriptor))
      YAML::load(::File.read("#{command}/artifacts.yaml"))
    rescue Errno::ENOENT => e
      nil
    end

    def save(model)
      raise PackWithoutImagesError unless model.has?(:images)
      ensure_space_for(model)
      model.auxiliary_texts.each { |t| save_text(t) }
      model.tap do |m|
        ::File.write("#{path_for(model)}/commit.json", m.emit.to_h_deep.to_json)
      end
    rescue PackWithoutImagesError => e
      warn(error: e, descriptor: model.identifier, klass: klass)
    end

    def export(model); execute(:export, model) ;end
    def commit(model); execute(:commit, model) ;end

    def push(model) ;end
    def fix(model) ;end
    # def inspect(model) ;end
    def validate(model) ;end

    def unexecuted_anchors_for(command, model)
      unique_anchors_for(model).reject { |d| encloses_good_result?(command, d) }
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
        FileUtils.mkdir_p("#{command}")
        ::File.write("#{command}/output.yaml", b.to_yaml)
        ::File.write("#{command}/artifacts.yaml", b.artifacts.to_yaml)
      end
    rescue PackWithoutImagesError => e
      warn(error: e, command: command, descriptor: model.identifier, klass: klass)
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
