require 'csv'
require_relative '../../installations/collaboration'

module Docker
  module Files
    module GroupPrecedence

      def group_precedence
        [:first, :early, :anywhere, :late, :last]
      end

      def as_csv
        CSV.generate do |csv|
          csv << ['collaborators'] + group_precedence
          Installations::Collaboration.all_collaborators.values.each do |c|
            csv << [c.name] + group_precedence.map { |g| c.step_precedence[g]&.join(' ') }
          end
        end
      end

      def save_csv
        f = ::File.open('step_precedence.csv', 'w')
        begin
          f.write(as_csv)
        ensure
          f.close
        end
      end

    end
  end
end
