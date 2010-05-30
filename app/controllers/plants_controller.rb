class PlantsController < ApplicationController
  def show
    @plant = Plant.find(params[:id])
    session[:plant_id] = params[:id]
  end

  def harvest
    lat = Float(params[:lat])
    lon = Float(params[:lon])
    radius = 0.08
    if lat and lon
      lat_lower_bound = lat - radius
      lat_upper_bound = lat + radius
      lon_lower_bound = lon - radius
      lon_upper_bound = lon + radius
      @nearby_plants = Plant.find_by_sql("SELECT * 
        FROM Plants 
        WHERE lat > #{lat_lower_bound} 
        AND lat < #{lat_upper_bound} 
        AND lon >  #{lon_lower_bound} 
        AND lon < #{lon_upper_bound}")
    else
      flash[:notice] = "Couldn't find any plants nearby #{lat}, #{lon}"
    end
    
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
    server = SERVER    
    #server = "seedbust.heroku.com/"
    if params[:share] 
      url = 'http://m.facebook.com/connect/prompt_feed.php?api_key=3bf44bb266e9d29f92d71fb103955006&attachment={'+
      '"name":"SeedBust",'+
      '"caption":"I+just+planted+a+seed+named+'+ params[:name] +'",'+
      '"description":"Take+a+seed+and+plant+it+to+show+your+support.",'+
      '"href":"http%3A%2F%2F' + server + '",' +
  '"media":[{"type":"image","src":"http://seedbust.heroku.com/images/maple.jpg","href":"http%3A%2F%2F' + server + '"}]}'+
      '&preview=1'+
      '&user_message_prompt=Tell+the+world+about+your+plant!'+
      '&callback=http%3A%2F%2F' + server + 'plants/show/'+ "#{@plant.id}" +
      '&cancel=http%3A%2F%2F' + server + 'plants/show/'+ "#{@plant.id}" +
      '&action_links=[{%22text%22%3A%22Get+My+Seed%22%2C%22href%22%3A%22http%3A%2F%2F'+ server +'&display=wap&r70f6588d'
      redirect_to url
    else
      redirect_to :action => :show, :id => @plant.id
    end 
  end
  
  def share
    friend_phones = params[:friend_phones].split(',')
    friend_phones.each do |phone_number|
      @response = ACCOUNT.request(\
          "/2008-08-01/Accounts/ACd68795defff7cfda994cfd09d6895fed/SMS/Messages", \
          "POST", { \
            "To" => phone_number, \
            "From" =>"415 366-6417", \
            "Body" => "Your friend #{current_user.fb_first_name} has sent you a new seed with SeedBust. Spread the seed here: http://seedbust.heroku.com/refer/#{session[:plant_id]}" })
      @response.body
      @response.code
    end
    session[:plant_id] = nil
    redirect_to :action => :thanks
  end
  
  def foursquare
    require 'oauth'
    require 'foursquare'
    oauth = session[:oauth]
    foursquare = Foursquare::Base.new(oauth)
    
    oauth = Foursquare::OAuth.new(FOURSQ_KEY, FOURSQ_SECRET)
    oauth.authorize_from_access(session[:access_token], session[:access_secret])
    foursquare = Foursquare::Base.new(oauth)
    
    logger.debug oauth
    logger.debug foursquare.friends
    @friends = foursquare.friends
  end

  def gift
  end
  
  def thanks
    @leaders = Plant.find_by_sql("SELECT Count(origin_user_id) AS TotalSpread FROM Plants ORDER BY TotalSpread DESC" )
  end

end
