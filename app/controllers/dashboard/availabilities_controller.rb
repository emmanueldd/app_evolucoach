module Dashboard
  class AvailabilitiesController < DashboardController
    before_action :set_availability, only: [:show, :edit, :update, :destroy]

    def index
      @date = params[:date].present? ? params[:date].to_datetime : DateTime.now
      @courses = current_user.courses
    end

    def create
      @availability = current_user.availabilities.new(availability_params)
      if @availability.save!
        respond_to do |format|
          format.json { render json: @availability, status: :ok }
        end
      end
    end

    def update
      if @availability.update!(availability_params)
        respond_to do |format|
          format.json { render json: @availability, status: :ok }
        end
      end
    end

    private
      def availability_params
        params.require(:availability).permit(:start_time, :available)
      end

      def set_availability
        @availability = current_user.availabilities.find(params[:id])
      end
  end
end
