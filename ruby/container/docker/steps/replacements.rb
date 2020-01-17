require_relative 'requires'

module Container
  module Docker
    class Replacements < Step

      def content
        context.tensor.struct.adaptations&.replacements&.map do |r|
          %Q(
            RUN cat #{r.source} | sed #{r.string} > #{tmp}
            RUN cp #{tmp} #{r.destination}
          )
        end
      end

    end
  end
end
