class SeedsController < ApplicationController
  def show
    @seeds = Type.find(:all, :order => :id)
  end

  def plant
  end

  def done
    
  end 
end
