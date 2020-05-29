  module Interface
  class ClientsController < InterfaceController
    before_action :set_client
    # Steps inscription client
    def edit
      @step = params[:step] || 1
    end

    def update
      @client.update(client_params)

      if params[:next_step] == 'completed'
        redirect_to interface_root_path
      else
        if @client.user.present?
          redirect_to @client.user
        else
          redirect_to edit_interface_client_path(step: params[:next_step])
        end
      end
    end

    private

      def set_client
        @client = current_client
      end

      def client_params
        if params[:client].present?
          params.require(:client).permit(:first_name, :last_name, :birth_date, :male, :city, :avatar, :phone)
        else
          {}
        end
      end

  end
end
