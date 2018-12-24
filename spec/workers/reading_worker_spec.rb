require 'rails_helper'
require 'pry'
RSpec.describe ReadingWorker, type: :worker do
  it { expect(ReadingWorker).to be_processed_in :reading }
  let(:thermostat){ create(:thermostat) }
  describe "#perform" do
    let(:temperature) { 1.0 }
    let(:humidity) { 2.0 }
    let(:battery_charge) { 3.0 }

    subject { 
      work = ReadingWorker.new
      work.perform({thermostat_id: thermostat.id,
        temperature: temperature,
        humidity: humidity, 
        battery_charge: battery_charge})
    }
    
    describe "success" do
      it { expect { subject }.to change { Reading.all.size }.from(0).to(1) }
      it "create Reading" do
        expect { subject }
          .to change { Reading.first&.slice(:thermostat_id, :temperature, :humidity, :battery_charge) }
          .from(nil)
          .to(
             {
               thermostat_id: thermostat.id,
               temperature: temperature,
               humidity: humidity,
               battery_charge: battery_charge
            }
          )
      end
    end
  end
end
