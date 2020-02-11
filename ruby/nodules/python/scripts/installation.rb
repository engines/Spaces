require_relative '../../../products/script'

module Nodules
  module Python
    module Scripts
      class Installation < Products::Script

        def body
          "python${python_version} -m pip install --upgrade #{context.name}"
        end

      end
    end
  end
end
