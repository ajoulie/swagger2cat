#!/usr/bin/env ruby

require 'json'
require './tree'

$json = JSON.parse(File.read("kubernetes_api.json"))

$cat = []
%w(swaggerVersion apiVersion basePath resourcePath).each do |k|
  puts "#{k} : #{$json[k].inspect}"
end

#puts $json["models"].size
#puts $json["apis"].size
#
#puts $json["apis"].first.keys.inspect
#puts $json["apis"].first.to_json


#puts
media_types = $json['models']
#puts media_types.select{|name, mt| mt["properties"].has_key?("items")}.keys
#puts
#puts media_types.keys.select{|mt_name| mt_name.match(/List$/)}

puts "\n\n"
t = $json["apis"].map do |api|
  "#{api['path']} (#{api['operations'].map{|o| o['method']}.join(', ')})"
end
puts t.sort


r = Tree::Root.new($json)
r.service("kubernetes")

%w(endpoints events limitranges podtemplates secrets serviceaccounts services).each do |resource|
  puts "generating #{resource}"
  pathes = $json["apis"].select do |api|
    ["/api/v1/namespaces/{namespace}/#{resource}/{name}", "/api/v1/namespaces/{namespace}/#{resource}"].include?(api["path"])
  end
  model_id=pathes.first["operations"].find {|o| o["method"] == "POST"}["parameters"].find{|p| p["paramType"] == "body"}["type"]
  model = media_types[model_id]
  r.type(resource[0..-2], pathes, model)
end

puts r.to_s

