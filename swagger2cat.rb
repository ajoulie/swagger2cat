#!/usr/bin/env ruby

require 'json'

#require './tree'
$json = JSON.parse(File.read("kubernetes_api.json"))

#file = File.open("kubernetes_namespace.cat", "w")

#def swaggerGeneration(version)
#  comment "CAT namespace file generated with swagger2CAT"
#  comment "from swagger specification #{version}"
#end
#
#def comment(com)
#  $cat << "# #{com}"
#end
#
#def service(name)
#  $cat << "service #{name} do"
#  yield
#  $cat <<  "end"
#end
#
#def host(value)
#  $cat << "  host \"#{value}\""
#end
#
#def no_cert_check(value)
#  $cat << "  no_cert_check \"#{value}\""
#end
#
#def path(value)
#  $cat << "  path \"#{value}\""
#end
#
#puts
#swaggerGeneration($json["swaggerVersion"])
#
#service("kubernetes") do |service|
#  host($json["basePath"])
#  path($json["resourcePath"])
#  no_cert_check(false)
#end

#puts $cat.join("\n")

$cat = []
%w(swaggerVersion apiVersion basePath resourcePath).each do |k|
  puts "#{k} : #{$json[k].inspect}"
end

puts $json["models"].size
puts $json["apis"].size

puts $json["apis"].first.keys.inspect
puts $json["apis"].first.to_json


puts
require './tree'
require './tree/service'
r = Tree::Root.new
r.comment "CAT namespace file generated with swagger2CAT"
r.comment "from swagger specification #{$json["swaggerVersion"]}"
r.service("kubernetes") do |serv|
  serv.comment "My first service is #{serv.value}"
  serv.host($json["basePath"])
  serv.path($json["resourcePath"])
  serv.no_cert_check(false)
end

puts r.to_s

puts "\n\n"
t = $json["apis"].map do |api|
  "#{api['path']} (#{api['operations'].map{|o| o['method']}.join(', ')})"
end
puts t.sort


