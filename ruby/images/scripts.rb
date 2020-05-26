require_relative '../spaces/constantizing'

module Images
  module Scripts
    include Spaces::Constantizing

    def scripts
      script_lot&.map { |s| script_for(s) }
    end

    def script_for(symbol)
      begin
        class_for(script_concern, symbol).new(self)
      rescue NameError
        general_script_for(symbol)
      end
    end

    def general_script_for(symbol)
      begin
        general_class_for(script_concern, symbol)
      rescue NameError => e
        warn(error: e, name: namespaced_name(namespace_for(script_concern), symbol))
      end&.new(self)
    end

    def script_lot; klass.script_lot ;end
    def script_concern; 'Scripts' ;end
    def script_path; 'scripts' ;end

  end
end
