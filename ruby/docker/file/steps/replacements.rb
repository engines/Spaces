require_relative 'requires'

module Docker
  class File < ::Spaces::Product
    class Replacements < Step

      def content
        context.tensor.struct.replacements&.map do |r|
          %Q(
            RUN cat #{r.source} | sed #{r.string} > tmp
            RUN cp tmp #{r.destination}
          )
        end
      end

    end
  end
end
