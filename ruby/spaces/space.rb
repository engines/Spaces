require_relative '../spaces/model'

module Spaces
  class Space < Model

    class << self
      def universe
        require_relative '../universal/space'
        @@universe ||= Universal::Space.new
      end
    end

    def save(model)
      f = File.open("#{file_name_for(model)}", 'w')
      begin
        f.write(model.contents)
      ensure
        f.close
      end
    end

    def save_yaml(model)
      f = File.open("#{file_name_for(model)}.yaml", 'w')
      begin
        f.write(model.to_yaml)
      ensure
        f.close
      end
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

    def ensure_space
      FileUtils.mkdir_p(path)
    end

    def universe
      self.class.universe
    end
  end
end
