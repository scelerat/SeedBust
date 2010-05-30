class Plant < ActiveRecord::Base
  belongs_to :planted_user, :class_name => 'User', :foreign_key => 'planted_user_id'
  belongs_to :origin_user, :class_name => 'User', :foreign_key => 'origin_user_id'
  belongs_to :type
end
