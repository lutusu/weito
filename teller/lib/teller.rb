require "teller/version"
require "teller/objectify"
require "teller/suger"
module Teller
  # Your code goes here...
end
class Object
  include Teller::Objectify
end