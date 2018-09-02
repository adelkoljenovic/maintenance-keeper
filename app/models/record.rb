class Record < ApplicationRecord
  has_many :shops
  has_many :vehicles
  belongs_to :user
end
