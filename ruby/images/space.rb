require_relative '../spaces/space'

module Images
  class Space < ::Spaces::Space

    def save(subject)
      subject.product.map do |t|
        save_text(t)
        "#{t.product_path}"
      end
    end

    def build(image)
      Docker::Image.build_from_dir(path_for(image), { 'dockerfile' => 'DockerFilesFile' })
    end

  end
end
