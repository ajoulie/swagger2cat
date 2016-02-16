require './tree/base'
require './tree/final'
require './tree/block'
require './tree/comment'
require './tree/root'

module Tree
  attr_final_class("Host")
  attr_final_class("Path")
  attr_final_class("NoCertCheck")
#
#  attr_block("Service")
end

