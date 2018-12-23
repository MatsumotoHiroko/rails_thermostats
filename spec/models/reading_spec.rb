require 'rails_helper'

RSpec.describe Reading, type: :model do
  it { should belong_to(:thermostat) }
  it { should validate_presence_of(:temperature) }
  it { should validate_presence_of(:humidity) }
  it { should validate_presence_of(:battery_charge) }

  describe "auto sequence" do
    let(:thermostat1) { create(:thermostat) }
    let(:thermostat2) { create(:thermostat) }
    let!(:reading1_1) { create(:reading, thermostat: thermostat1) }
    let!(:reading2_1) { create(:reading, thermostat: thermostat1) }
    let!(:reading1_2) { create(:reading, thermostat: thermostat2) }
    it "created successfuly" do
      expect(reading1_1.number).to eq(1)
      expect(reading2_1.number).to eq(2)
      expect(reading1_2.number).to eq(1)
    end
  end
end
