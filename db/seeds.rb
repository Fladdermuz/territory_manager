# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'open-uri'

if Rails.env.test?
 Country.create(code: "C#{i}",name: "C#{i}", region: 'South America')
else
response = Unirest.get "https://restcountries-v1.p.mashape.com/all",
  headers:{
    "X-Mashape-Key" => "63x4LUL69emshA6FO0XwGFSbHKnZp1Lhaz6jsnRLjc8S7bAAp4",
    "Accept" => "application/json"
  }


response.body.each do |c|

  if File.exist?("#{Rails.root}/public/images/flags/#{c['alpha2Code'].downcase}.png")
    Country.create(code: c['alpha2Code'].downcase,name: c['name'],region: c['subregion'],flag: File.new("#{Rails.root}/public/images/flags/#{c['alpha2Code'].downcase}.png"))
  else
    Country.create(code: c['alpha2Code'].downcase,name: c['name'],region: c['subregion'])
  end

end


end

User.create!(sitelang: "en",email: "blank",fname:"Admin",lname: "User",username: "admin", password: "ab1d48a0f8724f2fcec5fb9068344e6fz", isadmin:1, client_id:1)
Client.create!(name: "New", coordinate: "38.802859, -96.208728", country_id: 240)


MapLayer.create(name: 'Mapnik',layer_url: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',max_zoom: 18, provider: 'Open Street Maps')
MapLayer.create(name: 'Thunderforest TransportDark', layer_url: 'http://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png', max_zoom: 18, provider: 'Thunderforest')
MapLayer.create(name: 'Thunderforest Open Cycle Map', layer_url: 'http://{s}.tile.thunderforest.com/cycle/{z}/{x}/{y}.png', max_zoom: 18, provider: 'Thunderforest')
MapLayer.create(name: 'Thunderforest Outdoors', layer_url: 'http://{s}.tile.thunderforest.com/outdoors/{z}/{x}/{y}.png',max_zoom: 18,  provider: 'Thunderforest')
MapLayer.create(name: 'Thunderforest Pioneer', layer_url: 'http://{s}.tile.thunderforest.com/pioneer/{z}/{x}/{y}.png',max_zoom: 18,  provider: 'Thunderforest')
MapLayer.create(name: 'MapQuest OSM',file_ext: 'jpg',subdomains: '1234', map_type: 'map', layer_url: 'http://otile{s}.mqcdn.com/tiles/1.0.0/{type}/{z}/{x}/{y}.{ext}', max_zoom: 18,  provider: 'Map Quest')
MapLayer.create(subdomains: 'abcd', file_ext: 'png', name: 'Toner Background', layer_url: 'http://stamen-tiles-{s}.a.ssl.fastly.net/toner-background/{z}/{x}/{y}.{ext}',min_zoom: 0,  max_zoom: 18, provider: 'Stamen')
MapLayer.create(name: 'Esri.WorldStreetMap', layer_url: 'http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}', max_zoom: 18,  provider: 'ArcGIS')
MapLayer.create(name: 'Esri.DeLorme', layer_url: 'http://server.arcgisonline.com/ArcGIS/rest/services/Specialty/DeLorme_World_Base_Map/MapServer/tile/{z}/{y}/{x}', max_zoom: 11, provider: 'DeLorme')
MapLayer.create(name: 'Esri.WorldTopoMap', layer_url: 'http://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', max_zoom: 17,  provider: 'DeLorme')
MapLayer.create(name: 'World Imagery', layer_url: 'http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', max_zoom: 16,  provider: 'Esri')
MapLayer.create(name: 'DarkMatter', layer_url: 'http://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png', max_zoom: 18,provider: 'CartoDB')
MapLayer.create(name: 'HikeBike', layer_url: 'http://{s}.tiles.wmflabs.org/hikebike/{z}/{x}/{y}.png', max_zoom: 18, provider: 'Open Street Maps')
MapLayer.create(name: 'Hill Shading', layer_url: 'http://{s}.tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png', max_zoom: 15,  provider: 'Open Street Map')
