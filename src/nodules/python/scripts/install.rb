require_relative '../../../texts/script'

module Nodules
  module Python
    module Scripts
      class Install < Texts::Script

        def body
          "python${python_version} -m pip install --upgrade #{context.name}"
        end

      end
    end
  end
end
