require_relative '../../texts/script'

module Repositories
  module Scripts
    class AddRepository < Texts::Script
      def body
        %Q(
        echo "\n" | add-apt-repository '#{repo}'
        #{add_key_cmd}
     )
      end

      def identifier
        descriptor.identifier
      end

      def repo
        descriptor.repository
      end

      def key_url
        descriptor.key_url
      end

      def has_key_url?
        descriptor.respond_to?(:key_url)
      end

      def has_key_id?
        descriptor.respond_to?(:key_id)
      end

      def key_id
        descriptor.key_id
      end

      def add_key_cmd
        # :key_url and key_id optional and mutually exclusion can both be nil. key_id overides key_url
        "wget -qO - #{key_url} | sudo apt-key add - " if has_key_url?
        "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys #{key_id} " if has_key_id?
      end

      def descriptor
        context.descriptor
      end
    end
  end
end
