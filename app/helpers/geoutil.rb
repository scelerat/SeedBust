#!/usr/bin/env ruby
def earthDistance(lat1_deg,lng1_deg,lat2_deg,lng2_deg)
    """
    Computes dist between 2 points specified in lat/lng degrees.
    Returns value in meters.
    Converted from http://jan.ucc.nau.edu/~cvm/latlon_formula.html
    """
    earth_radius_meters = 6371000
    # convert to radians.
    pi = Math::PI
    lat1 = lat1_deg * pi / 180
    lng1 = lng1_deg * pi / 180
    lat2 = lat2_deg * pi / 180
    lng2 = lng2_deg * pi / 180

    #print "earth_dist(%f,%f,%f,%f)" %(lat1,lng1,lat2,lng2)
    
    a = Math.cos(lat1)*Math.cos(lng1)*Math.cos(lat2)*Math.cos(lng2)
    b = Math.cos(lat1)*Math.sin(lng1)*Math.cos(lat2)*Math.sin(lng2)
    c = Math.sin(lat1)*Math.sin(lat2)

    # Force sum into arccos -1..1 range to avoid numeric issues.
    q = a+b+c
    if q > 1
        q = 1
    elsif q < -1:
        q = -1
    end
    return (Math.acos(q) * earth_radius_meters)
end

if __FILE__ == $0
    sf_lat = 37
    sf_lng = 122
    
    ny_lat = 40
    ny_lng = 73
    puts "the distance from san francisco to new york in meters is: " #41259100
    puts earthDistance(sf_lat,sf_lng,ny_lat,ny_lng)
end
