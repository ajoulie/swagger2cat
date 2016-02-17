require_relative 'block'

module Tree
  class Field < Tree::Base
    include Tree::Block

    def initialize(value, json)
      super(value)
      type(json.fetch("type") {json.fetch("$ref")})
      required(true) if json["required"]
    end

    private
    def type(value)
      add Type.new(value)
    end

    def required(value)
      add Tree::Required.new(value)
    end

    class Type < Tree::Base
      def to_s(tab = 0)
        "#{' '*tab*2}type \"#{@value}\""
      end
    end
  end

end
   #"v1.Endpoints": {
   # "id": "v1.Endpoints",
   # "description": "Endpoints is a collection of endpoints that implement the actual service. Example:\n  Name: \"mysvc\",\n  Subsets: [\n    {\n      Addresses: [{\"ip\": \"10.10.1.1\"}, {\"ip\": \"10.10.2.2\"}],\n      Ports: [{\"name\": \"a\", \"port\": 8675}, {\"name\": \"b\", \"port\": 309}]\n    },\n    {\n      Addresses: [{\"ip\": \"10.10.3.3\"}],\n      Ports: [{\"name\": \"a\", \"port\": 93}, {\"name\": \"b\", \"port\": 76}]\n    },\n ]",
   # "required": [
   #  "subsets"
   # ],
   # "properties": {
   #  "kind": {
   #   "type": "string",
   #   "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: http://releases.k8s.io/HEAD/docs/devel/api-conventions.md#types-kinds"
   #  },
   #  "apiVersion": {
   #   "type": "string",
   #   "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: http://releases.k8s.io/HEAD/docs/devel/api-conventions.md#resources"
   #  },
   #  "metadata": {
   #   "$ref": "v1.ObjectMeta",
   #   "description": "Standard object's metadata. More info: http://releases.k8s.io/HEAD/docs/devel/api-conventions.md#metadata"
   #  },
   #  "subsets": {
   #   "type": "array",
   #   "items": {
   #    "$ref": "v1.EndpointSubset"
   #   },
   #   "description": "The set of all endpoints is the union of all subsets. Addresses are placed into subsets according to the IPs they share. A single address with multiple ports, some of which are ready and some of which are not (because they come from different containers) will result in the address being displayed in different subsets for the different ports. No address will appear in both Addresses and NotReadyAddresses in the same subset. Sets of addresses and ports that comprise a service."
   #  }
   # }
   #},
