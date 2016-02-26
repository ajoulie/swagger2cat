#!/usr/bin/env ruby

require 'json'
require './swagger2_cat'
require "./beta_code/kubernetes"

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
#puts media_types.select{|name, mt| mt["properties"].has_key?("items")}.keys
#puts
#puts media_types.keys.select{|mt_name| mt_name.match(/List$/)}

puts "\n\n"
t = $json["apis"].map do |api|
  "#{api['path']} (#{api['operations'].map{|o| o['method']}.join(', ')})"
end
puts t.sort


k = Kubernetes.new($json)
puts k.to_s
