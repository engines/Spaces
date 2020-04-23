require 'csv'
require_relative '../../installations/collaboration'
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
        f = ::File.open('step_precedence.csv', 'w')
        begin
          f.write(as_csv)
        ensure
          f.close
        end
      end

      def as_csv
        CSV.generate do |csv|
          csv << ['collaborators'] + group_precedence
          Installations::Collaboration.collaborator_map.values.each do |c|
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
