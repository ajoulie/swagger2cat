class Kubernetes
  include Swagger2Cat::Meth::Comment
  def initialize(spec)
    @spec = spec
    @children = []
    add Swagger2Cat::Name.new("Kubernetes Namespace")
    add Swagger2Cat::RsCaVer.new(20160209)
    add Swagger2Cat::ShortDescription.new("Namespace for interacting with Kubernetes")

    comment "CAT namespace file generated with swagger2CAT"
    comment "from swagger specification #{spec["swaggerVersion"]}"
    comment "My first namespace is Kubernetes"

    @cat = Swagger2Cat::Node::Namespace.new("kubernetes", spec)
    @cat.service
    add @cat

    Groups.each {|group| add_all(group)}
    add_kubernetes_custom
  end

  def add(child)
    @children << child
  end

  def to_s(tab = 0)
    @children.map{|c| c.to_s}
  end

  private
  attr_reader :spec, :cat
  Groups = [{
    endpoints: %w(endpoints events limitranges persistentvolumeclaims pods podtemplates replicationcontrollers resourcequotas secrets serviceaccounts services ),
    prefix: "namespace",
    regexp: "\/api\/v1\/namespaces\/{namespace}\/:resource"
  },{
    endpoints: %w( componentstatuses endpoints events limitranges namespaces nodes persistentvolumeclaims persistentvolumes pods podtemplates replicationcontrollers resourcequotas secrets serviceaccounts services),
    prefix: nil,
    regexp: "\/api\/v1\/:resource$|\/api\/v1\/:resource\/{name}$|\/api\/v1\/:resource\/{name}\/[^\/]*$"
  },{
    endpoints: %w(pods services nodes),
    prefix: "proxy",
    regexp: "\/api\/v1\/proxy\/namespaces\/{namespace}\/:resource|\/api\/v1\/proxy\/:resource"
  }]

  def add_all(config)
    config[:endpoints].each do |resource|
      puts "generating #{resource}" if ENV['DEBUG']
      pathes = spec["apis"].select do |api|
        api["path"].match(config[:regexp].gsub(":resource", resource))
      end
      next if pathes.empty?
      add_pathes(resource, pathes, config[:prefix])
    end
  end

  def add_pathes(resource, pathes, prefix = nil)
    media_types = spec['models']
    create_operation =pathes.first["operations"].find {|o| o["method"] == "POST"}
    cat.type(resource, pathes, media_types, create_operation, prefix)
  end

  def add_kubernetes_custom
    types = @cat.children.select {|child| child.is_a?(Swagger2Cat::Node::Type)}
    types.each do |type|
      output = type.children.find{|c| c.is_a?(Swagger2Cat::Node::Output)}
      next unless output

      output.instance_variable_set("@value", output.value + ["metadata.namespace", "metadata.name"])
    end
  end
end
