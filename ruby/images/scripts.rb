require_relative '../spaces/constantizing'

module Images
  module Scripts
    include Spaces::Constantizing

    def scripts
      script_lot&.map do |s|
        class_for('Scripts', s).new(self)
      rescue NameError => e
        warn(error: e, script: s)
      end
    end

    def script_lot
      klass.script_lot
    end

    def script_path
      'scripts'
    end

  end
end
