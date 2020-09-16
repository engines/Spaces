require_relative '../spaces/constantizing'

module Releases
  module Stanzas
    include Spaces::Constantizing

    def stanzas
      stanza_lot&.map { |s| stanza_for(s) }
    end

    def stanza_for(symbol)
      begin
        class_for(stanza_concern, symbol).new(self)
      rescue NameError => e
        warn(error: e, name: namespaced_name(namespace_for(stanza_concern), symbol))
      end
    end

    def stanza_lot; klass.stanza_lot ;end
    def stanza_concern; 'Stanzas' ;end
    def stanza_path; 'stanzas' ;end

  end
end
