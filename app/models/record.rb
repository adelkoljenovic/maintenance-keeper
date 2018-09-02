class Record < ApplicationRecord
  belongs_to :shop
  belongs_to :vehicle
  belongs_to :user
end
