require_relative '../spaces/space'

module Container
  class Space < ::Spaces::Space
    # The dimensions in which running live containers exist

    def save_tensor(model)
      f = File.open(tensor_file_name_for(model.struct.version.descriptor), 'w')
      begin
        f.write(model.to_yaml)
      ensure
        f.close
      end
    end

    def tensor_file_name_for(descriptor)
      ensure_subspace_for(descriptor)
      "#{subspace_name_for(descriptor)}/tensor.yaml"
    end

    def ensure_subspace_for(descriptor)
      FileUtils.mkdir_p(subspace_name_for(descriptor))
    end

    def subspace_name_for(descriptor)
      "#{path}/#{descriptor.name}"
    end

  end
end
