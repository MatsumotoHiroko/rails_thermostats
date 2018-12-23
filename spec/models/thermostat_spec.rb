require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  it { should have_many(:readings).dependent(:destroy) }
  it { should validate_presence_of(:household_token) }
  it { should validate_presence_of(:location) }
end
