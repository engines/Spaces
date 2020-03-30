require_relative '../spaces/constantizing'

module Images
  module Production
    include Spaces::Constantizing

    def script_lot
      klass.script_lot
    end

    def scripts
      script_lot&.map do |s|
        class_for('Scripts', s).new(self)
      rescue NameError
      end
    end

    def build_script_path
      'build/scripts'
    end

  end
end
