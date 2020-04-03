require_relative '../../texts/one_time_script'

module Repositories
  module Scripts
    class AddRepositories < Texts::OneTimeScript
      def body
        
      " add-apt-repository  #{context}"
#        context.map do |c|
#          %Q(
#          add-apt-repository '#{c.descriptor.value}'
#          #{add_key_cmd(c)}
#          )
#        end.join("\n")
      end

      def add_key_cmd(c)
        # :key_url and key_id optional and mutually exclusion can both be nil. key_id overides key_url
        "wget -qO - #{c.descriptor.key_url} | sudo apt-key add - " unless  c.descriptor.key_url.nil?
        "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys #{c.descriptor.key_id} " unless c.descriptor.key_id.nil?
      end
    end
  end
end
