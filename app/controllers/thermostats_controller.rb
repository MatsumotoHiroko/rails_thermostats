class ThermostatsController < ApplicationController
    before_action :set_thermostat, only: [:show]
    
      # GET /thermostats/:id
      def show
        render json: @thermostat.calucrate_readings
      end

    private
    
    def set_thermostat
      @thermostat = Thermostat.find(params[:id])
    end
end
