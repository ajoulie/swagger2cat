module Swagger2Cat
  module Node
    class Service < Base
      include Meth::Comment
      include Shape::Block

      def initialize(json)
        super(value)

        host(json["basePath"])
        path(json["resourcePath"])
        no_cert_check(false)
      end

      def host(value)
        add Host.new(value)
      end

      def path(value)
        add Path.new(value)
      end

      def no_cert_check(value)
        add NoCertCheck.new(value)
      end

      def name
        "service"
      end
    end
  end
end
