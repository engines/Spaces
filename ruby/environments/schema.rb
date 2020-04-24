require_relative '../spaces/schema'

module Environments
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          ports: [
            (0..),
            {
              port: 1,
              external: 0,
              protocol: 1
            }
          ],
          variables: [
            (0..),
            {
              name: 1,
              title: 0,
              type: 0,
              value: 0,
              ask_at_build_time: 0,
              build_time_only: 0
            }
          ],

        }
      end
    end

  end
end
