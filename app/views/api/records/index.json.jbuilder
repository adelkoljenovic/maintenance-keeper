json.array! @records.each do |record|
  json.id record.id
  json.vehicle_id record.vehicle_id
  json.maintenance_type record.maintenance_type
  json.current_mileage record.current_mileage
  json.date record.date
  json.shop_id record.shop_id
  json.user record.user
  json.shop record.shop
  json.vehicle record.vehicle
end
