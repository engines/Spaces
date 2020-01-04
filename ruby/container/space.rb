require_relative '../spaces/space'

module Container
  class Space < ::Spaces::Space
    # The dimensions in which running live containers exist

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

  end
end
