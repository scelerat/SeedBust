require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :plants
end
