class Item
  ##
  # Get the rough high/low lat/long bounds for a geographic point and
  # radius. Returns an array: <tt>[lat_lo, lat_hi, lon_lo, lon_hi]</tt>.
  # Used to constrain search to a (radius x radius) square.
  #
  def coordinate_bounds(latitude, longitude, radius)
    radius = radius.to_f
    factor = (Math::cos(latitude * Math::PI / 180.0) * 69.0).abs
    [
      latitude  - (radius / 69.0),
      latitude  + (radius / 69.0),
      longitude - (radius / factor),
      longitude + (radius / factor)
    ]
  end

  ##
  # This code is taken from the SQL query which the geocoder plugin throws (see vendor/plugin/geocoder/lib/geocoder.rb)
  # it is a monkey patch because ActiveRecord didnt let me include the addresses into the from field
  # more on this at http://stackoverflow.com/questions/3266358/geocoder-rails-plugin-near-search-problem-with-activerecord
  def find_nearby(lat, lon, miles=20)
    bounds = coordinate_bounds(lat, lon, miles)
    Item.find_by_sql(["SELECT *, 3956 * 2 * ASIN(SQRT(POWER(SIN((#{lat} - latitude) * PI() / 180 / 2), 2) + " +
      "COS(#{lat} * PI()/180) * COS(latitude * PI() / 180) * POWER(SIN((#{lon} - longitude) * PI() / 180 / 2), 2) ))" + 
      "AS distance FROM `addresses`, items" +
      " WHERE (latitude BETWEEN #{bounds[0]} AND #{bounds[1]} AND " + 
      " longitude BETWEEN #{bounds[2]} AND #{bounds[3]}) AND " + 
      "items.accepted IS NULL AND items.taken_by IS NULL AND " +
      "items.address_id = addresses.id ORDER BY distance ASC"])
  end
end