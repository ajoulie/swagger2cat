class Kubernetes
  def initialize(spec)
    @spec = spec
    @cat = Tree::Root.new(spec)
    @cat.service("kubernetes")

    Groups.each {|group| add_all(group)}

    #add_namespaced
    #add_root
    #add_others
  end

  def to_s
    @cat.to_s
  end

  private
  attr_reader :spec, :cat
  Groups = [{
    endpoints: %w(endpoints events),
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
      puts "generating #{resource}"
      pathes = spec["apis"].select do |api|
        api["path"].match(config[:regexp].gsub(":resource", resource))
      end
      next if pathes.empty?
      add_pathes(resource, pathes, config[:prefix])
    end
  end

  #def add_namespaced
  #  .each do |resource|
  #    puts "generating #{resource}"
  #    pathes = spec["apis"].select do |api|
  #      api["path"].match()
  #    end
  #    next if pathes.empty?
  #    add_pathes(resource, pathes, "namespace")
  #  end
  #end

  #def add_root
  #  %w().each do |resource|
  #    puts "generating #{resource}"
  #    pathes = spec["apis"].select do |api|
  #      api["path"].match()
  #    end
  #    next if pathes.empty?

  #    add_pathes(resource, pathes)
  #  end
  #end

  #def add_others
  #  .each do |resource|
  #    puts "generating #{resource}"
  #    pathes = spec["apis"].select do |api|
  #      api["path"].match(/\/api\/v1\/proxy\/namespaces\/{namespace}\/#{resource}|\/api\/v1\/proxy\/#{resource}/)
  #    end
  #    next if pathes.empty?
  #    add_pathes(resource, pathes, "proxy")
  #  end
  #end

  def add_pathes(resource, pathes, prefix = nil)
    media_types = spec['models']
    create_operation =pathes.first["operations"].find {|o| o["method"] == "POST"}
    unless create_operation.nil?
      create_operation = create_operation["parameters"].find{|p| p["paramType"] == "body"}
    end
    unless create_operation.nil?
      model= media_types[create_operation["type"]]
    end
    cat.type(resource, pathes, model, prefix)
  end
end
