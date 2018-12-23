class ReadingsController < ApplicationController
    before_action :set_thermostat
    before_action :set_reading, only: [:show]

    # POST /thermostats/:thermostat_id/readings/
    def create
        reading = @thermostat.readings.build(reading_params)
        if reading.valid?
          number = @thermostat.readings.maximum(:number).to_i+1
        
          ReadingWorker.perform_async(reading_params.to_hash.merge({thermostat_id: @thermostat.id}))
          json_response({number: number }, :accepted)
        else
          json_response(reading.errors.messages, :unprocessable_entity)
        end
      end
    
      # GET /thermostats/:thermostat_id/readings/:id
      def show
        json_response(@reading)
      end

    private

    def reading_params
      # whitelist params
      params.permit(:temperature, :humidity, :battery_charge)
    end

    def set_thermostat
      @thermostat = Thermostat.find(params[:thermostat_id])
    end

    def set_reading
      @reading = Reading.find(params[:id])
    end
end
