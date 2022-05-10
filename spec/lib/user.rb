require 'faker'
require_relative 'user_constructed' 

 class User
  include UserConstructed
  attr_accessor :email, :first_name, :last_name, :middle_name
 end
