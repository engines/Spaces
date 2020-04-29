require_relative '../bridges/space'
require_relative '../docker/images/space'

module Images
  class Space < ::Bridges::Space

    delegate([:from_subject, :from_tar] => :bridge)

    def save(subject)
      subject.product.map do |t|
        save_text(t)
        "#{t.product_path}"
      end
    end

    define_method (:bridge) { @bridge ||= Docker::Images::Space.new(self) }

  end
end
