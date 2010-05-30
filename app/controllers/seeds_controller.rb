class SeedsController < ApplicationController
  def show
    @seeds = Type.find(:all, :order => :id)
  end

  def plant
    @plant = Plant.new
    @plant.state = 'PLANTED'
    @plant.lat = params[:lat]
    @plant.lon = params[:lon]
    @plant.origin_user_id = session[:user]
    @plant.planted_user_id = session[:user]
    @plant.save
  end

  def done
    
  end
  
  def position
    session[:seed_id] = params[:id]
    @seed = Type.find_by_id(params[:id])
  end
  
end
