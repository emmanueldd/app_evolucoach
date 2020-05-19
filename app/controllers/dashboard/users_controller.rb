module Dashboard
  class UsersController < DashboardController
    before_action :set_profile_box

    def show
    end

    def edit
    end

    def update
      redirect_to dashboard_users_path if @user.update(user_params)
    end

    def destroy
      redirect_to dashboard_users_path if @user.destroy
    end

    private
      def user_params
        params.require(:user).permit(:name, :client, :description, :price)
      end
  end
end
