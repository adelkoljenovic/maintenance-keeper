class User < ApplicationRecord
  has_secure_password
  has_many :vehicles
  has_many :shops
  has_many :records
end
