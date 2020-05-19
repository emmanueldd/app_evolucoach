module Dashboard
  class UserHasClientsController < DashboardController
    before_action :set_user_has_client, only: [:show, :edit, :update, :destroy]
    def index
      @clients = current_user.user_has_clients
    end

    def show
    end

    def new
      @user_has_client = current_user.user_has_clients.new
    end

    def create
      @user_has_client = current_user.user_has_clients.new(user_has_client_params)
      redirect_to edit_dashboard_user_has_client_path(@user_has_client) if @user_has_client.save!
    end


    def edit
    end

    def update
      if @user_has_client.update(user_has_client_params)
        if params[:user_has_client][:next_step].present?
          redirect_to edit_dashboard_user_has_client_path(step: params[:user_has_client][:next_step])
        else
          redirect_to [:dashboard, current_user], notice: 'Pack enregistré'
        end
      end
    end

    def destroy
      redirect_to dashboard_user_has_clients_path if @user_has_client.destroy
    end

    private
      def user_has_client_params
        params.require(:user_has_client).permit(:name, :unit_price, :nb_of_courses, :description, :published)
      end

      def set_user_has_client
        @user_has_client = current_user.user_has_clients.find(params[:id])
      end
  end
end
