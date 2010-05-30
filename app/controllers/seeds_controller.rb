class SeedsController < ApplicationController
  before_filter :login_required
  def show
    # if already has plant then send it to the position finder
      
    if session[:plant] then redirect_to :action => :position, :id => session[:plant].type_id end
    @seeds = Type.find(:all, :order => :id)
  end

  def plant
    @plant = Plant.new
    @plant.state = 'PLANTED'
    @plant.lat = params[:lat]
    @plant.lon = params[:lon]
    @plant.type_id = params[:type_id]
    if session[:plant] then 
       @plant.origin_user_id = session[:plant].origin_user_id
       @plant.parent_plant_id = session[:plant].id
    else
       @plant.origin_user_id = current_user.id
    end
    @plant.planted_user_id = current_user.id
    @plant.save
  end

  def done
    
  end
  
  def position
    #session[:seed_id] = params[:id]
    @seed = Type.find_by_id(params[:id])
  end
  
  def plant_existing 
    @plant = Plant.find(params[:plant_id])
    
  end
end
