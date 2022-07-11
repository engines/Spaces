module Images
  class Space < ::Emissions::InterfaceSpace

    def all = super.select(&:tagged?)

    def history(identifier) =
      interfaces.map { |i| i.by(identifier) }.first.history
      #TODO: what happens when there are multiple interfaces?

  end
end
