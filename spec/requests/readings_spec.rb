require 'rails_helper'

RSpec.describe 'readings API', type: :request do
  # initialize test data 
  let!(:readings) { create_list(:reading, 10) }
  let(:reading_id) { readings.first.id }
  let(:thermostat_id) { readings.first.thermostat_id }
  # Test suite for GET /thermostats/:thermostat_id/readings/:id
  describe 'GET /thermostats/:thermostat_id/readings/:id' do
    before { get "/thermostats/#{thermostat_id}/readings/#{reading_id}" }

    context 'when the record exists' do
      it 'returns the reading' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(reading_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:reading_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Reading/)
      end
    end
  end

  # Test suite for POST /thermostats/:thermostat_id/readings
  describe 'POST /thermostats/:thermostat_id/readings' do
    # valid payload
    let!(:thermostat){ create(:thermostat) }
    let(:thermostat_id) { thermostat.id }

    let(:valid_attributes) { { temperature: 1.0, humidity: 1.2, battery_charge: 1.3 } }

    context 'when the request is valid' do
      before { post "/thermostats/#{thermostat_id}/readings", params: valid_attributes }

      it 'creates a reading' do
        expect(json['number']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when the request is invalid' do
      before { post "/thermostats/#{thermostat_id}/readings", params: { temperature: 1.2 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['humidity'])
          .to match([/can't be blank/, /is not a number/])
      end
    end
  end
end