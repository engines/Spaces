require_relative '../spaces/model'

module Framework
  class Framework < ::Spaces::Model

  def startup_layer
    "ADD home/start.sh #{start_script_path}"
  end

  def start_layers
    %Q(
      USER $ContUser
      CMD ["#{start_script_path}"]
    )
  end

  def start_script_path
    '/home/spaces/scripts/startup/start.sh'
  end

    def identifier
      self.class.identifier
    end
  end
end
