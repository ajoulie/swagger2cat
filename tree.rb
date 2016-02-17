require './tree/base'
require './tree/final'
require './tree/final_multiple'
require './tree/block'
require './tree/sequence'
require './tree/comment'
require './tree/root'
require './tree/service'
require './tree/type'
require './tree/fields'
require './tree/field'
require './tree/output'
require './tree/actions'
require './tree/action_custom'
require './tree/action_crud'
require './tree/href'
require './tree/path'

module Tree
  attr_final_class("Host")
  attr_final_class("NoCertCheck")
  attr_final_class("Required")
end

