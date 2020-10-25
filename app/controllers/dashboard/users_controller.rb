module Dashboard
  class UsersController < DashboardController
    before_action :set_profile_box, only: [:show]

    def show
    end

    def edit
      @user = current_user
      @step = params[:step] || 1
    end

    def update
      if current_user.update!(user_params)
        redirect_to dashboard_stats_path, notice: ''
      end
    end

    def update
      fb_pixel_code_was = current_user.fb_pixel_code.to_s
      current_user.update!(user_params)
      if params[:next_step] == 'completed'
        redirect_to dashboard_user_path(current_user), notice: 'Informations mises à jour'
      elsif params[:next_step].present?
        redirect_to edit_dashboard_user_path(step: params[:next_step])
      elsif user_params[:financial_goal].present?
        redirect_to dashboard_stats_path, notice: 'Ton objectif financier a été mis à jour.'
      elsif user_params[:ga_code].present? || user_params[:fb_pixel_code].present?
        does_fb_pixel_changed = fb_pixel_code_was != current_user.fb_pixel_code
        redirect_to dashboard_stats_params_path(set_default_trackings: does_fb_pixel_changed), notice: 'Ton tracking Facebook a bien été mis à jour.'
      end
    end

    def destroy
      redirect_to dashboard_users_path if current_user.destroy
    end

    private
      def user_params
        params.require(:user).permit(:name, :client, :description, :price, :financial_goal, :first_name, :last_name, :avatar, :city, :ga_code, :fb_pixel_code)
      end
  end
end
