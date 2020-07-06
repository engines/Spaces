require_relative '../bridges/space'

module Images
  class Space < ::Bridges::Space

    def save(subject)
      subject.components.map do |t|
        save_text(t)
        "#{t.release_path}"
      end
    end

  end
end
