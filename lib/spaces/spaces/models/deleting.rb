module Spaces
  module Deleting

    def delete(identifiable, cascade: true)
      identifiable.tap do |i|
        delete_cascades(i, cascade: true)
        writing_path_for(i.identifier).rmtree
      end
    rescue Errno::ENOENT
      raise ::Spaces::Errors::LostInSpace, {space: identifier, identifier: identifiable.identifier.to_sym}
    end

    def delete_cascades(identifiable, cascade: true)
      cascade_deletes.each { |c| universe.send(c).maybe_delete(identifiable) } if cascade
    end

    def maybe_delete(identifiable, cascade: true)
      delete(identifiable, cascade: cascade) if exist?(identifiable)
    end

    def cascade_deletes; [] ;end

  end
end
