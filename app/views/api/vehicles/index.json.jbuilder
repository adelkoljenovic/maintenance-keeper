json.array! @vehicles.each do |vehicle|
  json.id vehicle.id
  json.vin vehicle.vin
  json.year vehicle.year 
  json.make vehicle.make
  json.model vehicle.model
  json.user vehicle.user
end
