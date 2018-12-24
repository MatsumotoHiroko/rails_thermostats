class Reading < ApplicationRecord
  belongs_to :thermostat
  validates_presence_of :thermostat_id, :temperature, :humidity, :battery_charge
  acts_as_sequenced scope: :thermostat_id, column: :number

  validates :temperature, :humidity, :battery_charge, numericality: true
end
