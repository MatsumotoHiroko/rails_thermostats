class Thermostat < ApplicationRecord
  has_many :readings, dependent: :destroy

  validates_presence_of :household_token, :location

  validates :household_token, length: { maximum: 1000 }
  validates :location, length: { maximum: 500 }
end
