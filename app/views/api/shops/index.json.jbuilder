json.array! @shops.each do |shop|
  json.id shop.id
  json.name shop.name
  json.address shop.address
  json.contact_name shop.contact_name
  json.telephone_number shop.telephone_number
  json.notes shop.notes
  json.user shop.user
end


