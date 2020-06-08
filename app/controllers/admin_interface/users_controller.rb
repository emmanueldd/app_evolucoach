module AdminInterface
  class UsersController < AdminInterfaceController
    def connect_as
      @user = User.find(params[:id])
      sign_in(:user, @user)
      redirect_to root_path
    end
  end
end
