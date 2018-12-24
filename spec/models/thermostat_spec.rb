require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  it { should have_many(:readings).dependent(:destroy) }
  it { should validate_presence_of(:household_token) }
  it { should validate_presence_of(:location) }

  describe "#calucrate_readings" do
    let(:thermostat) { create(:thermostat) }
    describe "having several data in Reading" do
      let!(:reading1) { create(:reading, thermostat: thermostat, temperature: 1.0, humidity: 2.0, battery_charge: 3.0) }
      let!(:reading2) { create(:reading, thermostat: thermostat, temperature: 2.0, humidity: 4.0, battery_charge: 6.0) }
      it "calucrated" do
        answer = thermostat.calucrate_readings
        expect(answer[:temperature][:average]).to eq(1.5)
        expect(answer[:humidity][:average]).to eq(3.0)
        expect(answer[:battery_charge][:average]).to eq(4.5)

        expect(answer[:temperature][:minimum]).to eq(1.0)
        expect(answer[:humidity][:minimum]).to eq(2.0)
        expect(answer[:battery_charge][:minimum]).to eq(3.0)

        expect(answer[:temperature][:maximum]).to eq(2.0)
        expect(answer[:humidity][:maximum]).to eq(4.0)
        expect(answer[:battery_charge][:maximum]).to eq(6.0)
      end
    end
    describe "having no data in Reading" do
      it "return nil" do
        answer = thermostat.calucrate_readings
        expect(answer[:temperature][:average]).to eq(nil)
        expect(answer[:humidity][:average]).to eq(nil)
        expect(answer[:battery_charge][:average]).to eq(nil)

        expect(answer[:temperature][:minimum]).to eq(nil)
        expect(answer[:humidity][:minimum]).to eq(nil)
        expect(answer[:battery_charge][:minimum]).to eq(nil)

        expect(answer[:temperature][:maximum]).to eq(nil)
        expect(answer[:humidity][:maximum]).to eq(nil)
        expect(answer[:battery_charge][:maximum]).to eq(nil)
      end

    end
  end
end
