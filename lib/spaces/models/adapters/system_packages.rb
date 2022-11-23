module Adapters
  class SystemPackages < Division
    include Keyed

    delegate(
      system_dependencies: :adapter,
      [:adds, :removes] => :struct
    )

    def struct =
      OpenStruct.new(
        adds: adds_considering_dependencies,
        removes: removes_considering_dependencies
      ).compact

    def adds_considering_dependencies =
      dependencies_considered(system_dependencies, blueprinted(:adds))

    def removes_considering_dependencies =
      dependencies_considered(system_dependencies - blueprinted(:adds), blueprinted(:removes))

    def blueprinted(key) =
      division.struct[key]&.map(&:to_sym)

    def dependencies_considered(*args) =
      args.flatten.compact.uniq.nilify

  end
end
