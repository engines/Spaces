require_relative 'model'

module Spaces
  class Space < Model

    class << self
      def universe
        require_relative '../universal/space'
        @@universe ||= Universal::Space.new
      end
    end

    def save(model)
      save_dependency_content_for(model) if model.respond_to?(:dependencies)
      f = File.open("#{file_name_for(model)}", 'w')
      begin
        f.write(model.content)
      ensure
        f.close
      end
    end

    def save_dependency_content_for(model)
      unsaved_dependency_content(model).each { |m| save(m) }
    end

    def unsaved_dependency_content(model)
      model.dependencies.reject { |m| encloses?(file_name_for(model)) }
    end

    def save_yaml(model)
      save_dependency_yaml_for(model) if model.respond_to?(:dependencies)
      f = File.open("#{file_name_for(model)}.yaml", 'w')
      begin
        f.write(model.to_yaml)
      ensure
        f.close
      end
    end

    def save_dependency_yaml_for(model)
      unsaved_dependency_yaml(model).each { |m| save_yaml(m) }
    end

    def unsaved_dependency_yaml(model)
      model.dependencies.reject { |m| encloses?("#{file_name_for(model)}.yaml") }
    end

    def encloses?(file_name)
      Dir.exist?(file_name)
    end

    def file_name_for(model)
      ensure_subspace_for(model)
      "#{path}/#{model.file_path}"
    end

    def ensure_subspace_for(model)
      FileUtils.mkdir_p(subspace_path_for(model))
    end

    def subspace_path_for(model)
      "#{path}/#{model.subspace_path}"
    end

    def path
      "#{universe.path}/#{identifier}"
    end

    def identifier
      self.class.identifier
    end

    def ensure_space
      FileUtils.mkdir_p(path)
    end

    def universe
      self.class.universe
    end
  end
end
