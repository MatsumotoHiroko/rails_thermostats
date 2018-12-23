require 'rails_helper'

RSpec.describe 'thermostats API', type: :request do
  # initialize test data 
  let!(:thermostat) { create(:thermostat) }
  let!(:reading1) { create(:reading, thermostat: thermostat, temperature: 1.0, humidity: 2.0, battery_charge: 3.0) }
  let!(:reading2) { create(:reading, thermostat: thermostat, temperature: 2.0, humidity: 4.0, battery_charge: 6.0) }

  let(:thermostat_id) { thermostat.id }
  # Test suite for GET /thermostats/:id
  describe 'GET /thermostats/:id' do
    before { get "/thermostats/#{thermostat_id}" }

    context 'when the record exists' do
      it 'returns the thermostat' do
        expect(json).not_to be_empty
        expect(json['temperature']['average']).to eq(1.5)
        expect(json['humidity']['average']).to eq(3.0)
        expect(json['battery_charge']['average']).to eq(4.5)

        expect(json['temperature']['minimum']).to eq(1.0)
        expect(json['humidity']['minimum']).to eq(2.0)
        expect(json['battery_charge']['minimum']).to eq(3.0)

        expect(json['temperature']['maximum']).to eq(2.0)
        expect(json['humidity']['maximum']).to eq(4.0)
        expect(json['battery_charge']['maximum']).to eq(6.0)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:thermostat_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Thermostat/)
      end
    end
  end
end