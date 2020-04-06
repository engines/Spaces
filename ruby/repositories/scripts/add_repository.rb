require_relative '../../texts/script'

module Repositories
  module Scripts
    class AddRepository < Texts::Script
      def body
        %Q(
        echo "\n" | add-apt-repository '#{repository}'
        #{add_key_cmd}
     )
      end

      def has_key_url?
        descriptor.respond_to?(:key_url)
      end

      def has_key_id?
        descriptor.respond_to?(:key_id)
      end
      
      delegate(
        descriptor: :context,
        [:identifier, :repository, :key_url, :key_id ] => :descriptor
      )

      def add_key_cmd
        # :key_url and key_id optional and mutually exclusion can both be nil. key_id overides key_url
        "wget -qO - #{key_url} | sudo apt-key add - " if has_key_url?
        "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys #{key_id} " if has_key_id?
      end

    end
  end
end
