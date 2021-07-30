module Spaces
  module Deleting

    def delete(identifiable, cascade: true)
      identifiable.tap do |i|
        cascade_deletes.each { |s| universe.send(s).delete(i) } if cascade

        writing_path_for(i.identifier).rmtree
      end
    rescue Errno::ENOENT
      raise ::Spaces::Errors::LostInSpace, {space: identifier, identifier: identifiable.identifier.to_sym}
    end

    def cascade_deletes; [] ;end

  end
end
