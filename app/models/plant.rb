class Plant < ActiveRecord::Base
  belongs_to :planted_user, :class_name => 'User', :foreign_key => 'planted_user_id'
  belongs_to :origin_user, :class_name => 'User', :foreign_key => 'origin_user_id'
  belongs_to :type
  
  def self.leaders
    #@leaders = self.find(:all)
    # thing = 'nothing'
    #     total_visits = @leaders.inject(0) do |sum, stat|
    #       sum  = stat.origin_user_id
    #       thing = thing + sum.to_s
    #     end
    #     thing
    #@leaders.collect(&:origin_user_id).sum.to_f
    #/@leaders.length if @leaders.length > 0
    
    @leaders = self.find_by_sql("SELECT Count(origin_user_id) AS CountOfID, origin_user_id FROM Plants GROUP BY Origin_user_id ORDER BY CountOfID DESC")
  end
end
