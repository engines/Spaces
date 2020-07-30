require 'packer'
require_relative '../spaces/space'
require_relative 'builders/space'

module Packing
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Pack
      end
    end

    alias_method :by, :by_json

    def builders
      @builders ||= Builders::Space.new
    end

    def save_json(model)
      model.tap do |m|
        ::File.write("#{path_for(model)}/export.json", m.export.deep_to_h.to_json)
        ::File.write("#{path_for(model)}/commit.json", m.memento.deep_to_h.to_json)
      end
    end

    alias_method :save, :save_json

    def export(model); execute(:export, model) ;end
    def commit(model); execute(:commit, model) ;end

    def push(model) ;end
    def fix(model) ;end
    # def inspect(model) ;end
    def validate(model) ;end

    protected

    def execute(command, model)
      save(model).tap do |m|
        Dir.chdir(path_for(m))
        bridge.build("#{command}.json").tap do |b|
          FileUtils.mkdir_p("#{command}")
          ::File.write("#{command}/output.yaml", b.to_yaml)
          ::File.write("#{command}/artifacts.yaml", b.artifacts.to_yaml)
        end
      end
    end

    def bridge
      @builder ||= Packer::Client.new
    end

  end
end
