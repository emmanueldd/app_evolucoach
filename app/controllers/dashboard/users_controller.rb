module Dashboard
  class UsersController < DashboardController
    before_action :set_profile_box

    def show
    end

    def edit
    end

    def update
      if current_user.update(user_params)
        redirect_to dashboard_stats_path, notice: 'Ton objectif financier a été mis à jour.'
      end
    end

    def destroy
      redirect_to dashboard_users_path if current_user.destroy
    end

    private
      def user_params
        params.require(:user).permit(:name, :client, :description, :price, :financial_goal, :first_name, :last_name)
      end
  end
end
