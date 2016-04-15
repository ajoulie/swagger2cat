class CompilationService
  include Swagger2Cat::Meth::Comment
  def initialize(spec)
    @spec = spec
    @children = []
    add Swagger2Cat::Name.new("Compilation Namespace")
    add Swagger2Cat::RsCaVer.new(20160209)
    add Swagger2Cat::ShortDescription.new("Namespace for interacting with Compilation Service")

    comment "CAT namespace file generated with swagger2CAT"
    comment "from swagger specification #{spec["swaggerVersion"]}"
    comment "My first namespace is Kubernetes"

    @cat = Swagger2Cat::Node::Namespace.new("CompilationService", spec)

    @cat.service
    @cat.path(spec['paths'].first)
    @cat.type(resource, pathes, media_types, create_operation, prefix)
    add @cat
  end

  def add(child)
    @children << child
  end

  def to_s(tab = 0)
    @children.map{|c| c.to_s}
  end
end
