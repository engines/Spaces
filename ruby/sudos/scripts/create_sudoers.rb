require_relative '../../texts/one_time_script'

module Sudos
  module Scripts
    class CreateSudoers < Texts::OneTimeScript
      def body
        r = ''
        context.all.each do |c|
          r += %Q(
           echo $CONT_USER ALL=(ALL) NOPASSWD: #{c} >> /etc/sudoers.d/engine
        )
        end
        r += "\n\n"
      end

    end
  end
end
