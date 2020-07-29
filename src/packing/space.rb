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
      super
      ::File.write(export_name_for(model), model.export.deep_to_h.to_json)
      ::File.write(commit_name_for(model), model.commit.deep_to_h.to_json)
    end

    alias_method :save, :save_json

    def export(model)
      save(model)
      Dir.chdir(path_for(model))
      bridge.build(export_name_for(model))
    end

    def commit(model)
      save(model)
      Dir.chdir(path_for(model))
      bridge.build(commit_name_for(model))
    end

    def export_name_for(model); "#{path_for(model)}/export.json" ;end
    def commit_name_for(model); "#{path_for(model)}/commit.json" ;end

    def push(model) ;end
    def fix(model) ;end
    # def inspect(model) ;end
    def validate(model) ;end

    protected

    def bridge
      @builder ||= Packer::Client.new
    end

  end
end
