module Spaces
  module Deleting

    def exist_then_delete(identifiable)
      exist_then(identifiable) { delete(identifiable) }
    end

    def delete(identifiable, cascade: true)
      insist(deletion_precondition(identifiable))
      identifiable.tap { |i| _delete(i, cascade: cascade) }
    rescue Errno::ENOENT
      raise_lost_error(identifiable)
    end

    def deletion_precondition(identifiable) = {}

    def delete_cascades(identifiable, cascade: true)
      cascade_deletes.each { |c| universe.send(c).maybe_delete(identifiable) } if cascade
    end

    def maybe_delete(identifiable, cascade: true)
      delete(identifiable, cascade: cascade) if exist?(identifiable)
    end

    def cascade_deletes = []

    protected

    def _delete(identifiable, cascade: true)
      delete_cascades(identifiable, cascade: cascade)
      writing_path_for(identifiable).rmtree
    end

  end
end
