class ThermostatsController < ApplicationController
    before_action :set_thermostat, only: [:show]
    
      # GET /thermostats/:id
      def show
        readings = @thermostat.readings
        render json: {
          temperature: {average: @thermostat.readings.average(:temperature).to_f, minimum: @thermostat.readings.minimum(:temperature), maximum: @thermostat.readings.maximum(:temperature)},
          humidity: {average: @thermostat.readings.average(:humidity).to_f, minimum: @thermostat.readings.minimum(:humidity), maximum: @thermostat.readings.maximum(:humidity)},
          battery_charge: {average: @thermostat.readings.average(:battery_charge).to_f, minimum: @thermostat.readings.minimum(:battery_charge), maximum: @thermostat.readings.maximum(:battery_charge)}
        }
      end

    private
    
    def set_thermostat
      @thermostat = Thermostat.find(params[:id])
    end
end
