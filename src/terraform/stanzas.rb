require_relative '../spaces/constantizing'

module Terraform
  module Stanzas
    include Spaces::Constantizing

    def stanzas
      stanza_lot&.map { |s| stanza_for(s) }&.map(&:declaratives)
    end

    def stanza_for(symbol)
      begin
        class_for(stanza_concern, symbol).new(self)
      rescue NameError
        warn(error: e, name: namespaced_name(namespace_for(stanza_concern), symbol))
      end
    end

    def stanza_lot; klass.stanza_lot ;end
    def stanza_concern; 'Stanzas' ;end
    def stanza_path; 'stanzas' ;end

  end
end
