require 'csv'
require_relative '../../installations/release'
require_relative '../../frameworks/space'
require_relative '../../frameworks/subclasses'
require_relative '../../nodules/space'
require_relative '../../nodules/subclasses'

module Docker
  module Files
    module GroupPrecedence

      def group_precedence
        [:first, :early, :anywhere, :late, :last]
      end

      def save_csv
        ::File.write('step_precedence.csv', as_csv)
      end

      def as_csv
        CSV.generate do |csv|
          csv << ['divisions'] + group_precedence
          Installations::Installation.divisions.values.each do |c|
            csv << line_for(c)
            Frameworks::Space.loaded.each { |l| csv << line_for(l) } if c == Frameworks::Framework
            Nodules::Space.loaded.each { |l| csv << line_for(l) } if c == Nodules::Nodules
          end
        end
      end

      def line_for(klass)
        [klass.name] + group_precedence.map { |g| klass.step_precedence[g]&.join(' ') }
      end

    end
  end
end
