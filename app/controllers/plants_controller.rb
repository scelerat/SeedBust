class PlantsController < ApplicationController
  def show
  end

  def harvest
  end

  def mine
  end

  def edit
    @plant = Plant.find_by_id(params[:id])
  end
  
  def update_name
    @plant = Plant.find_by_id(params[:id])
    @plant.name = params[:name]
    @plant.save
    session[:plant] = @plant
    server = "localhost:3000/"    
    #server = "seedbust.heroku.com/"
    if params[:share] 
      url = 'http://m.facebook.com/connect/prompt_feed.php?api_key=3bf44bb266e9d29f92d71fb103955006&attachment={'+
      '"name":"SeedBust",'+
      '"caption":"I+just+planted+a+seed+named+'+ params[:name] +'",'+
      '"description":"Take+a+seed+and+plant+it+to+show+your+support.",'+
      '"href":"http%3A%2F%2F' + server + '",' +
  '"media":[{"type":"image","src":"http%3A%2F%2Fimg363.imageshack.us%2Fimg363%2F9931%2F9122plantcartoonls8.jpg","href":"http%3A%2F%2F' + server + '"}]}'+
      '&preview=1'+
      '&user_message_prompt=Tell+the+world+about+your+plant!'+
      '&callback=http%3A%2F%2F' + server + 'plants/show'+
      '&cancel=http%3A%2F%2F' + server + 'plants/show'+
      '&action_links=[{%22text%22%3A%22Get+My+Seed%22%2C%22href%22%3A%22http%3A%2F%2F174.143.153.39%2Fseedbust%2Findex.html&display=wap&r70f6588d'
      redirect_to url
    else
      redirect_to :action => :show
    end 
  end

  def share
  end
  
  def foursquare
  end

  def gift
  end
  
  def thanks
  end

end
