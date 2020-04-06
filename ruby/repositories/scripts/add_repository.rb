require_relative '../../texts/one_time_script'

module Repositories
  module Scripts
    class AddRepository < Texts::Script
      def body
        %Q(
        add-apt-repository '#{repo}'
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

      def key_id
        c.descriptor.key_id
      end

      def add_key_cmd
        # :key_url and key_id optional and mutually exclusion can both be nil. key_id overides key_url
        "wget -qO - #{key_url} | sudo apt-key add - " unless  key_url.nil?
        "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys #{key_id} " unless c.descriptor.key_id.nil?
      end
    end
  end
end
