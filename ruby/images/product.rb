require_relative '../spaces/constantizing'

module Images
  module Product
    include Spaces::Constantizing

    def scripts
      script_lot&.map do |s|
        class_for('Scripts', s).new(self)
      rescue NameError
      end
    end

    def script_lot
      klass.script_lot
    end

    def product_path
      'scripts'
    end

  end
end
