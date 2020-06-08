module AdminInterface
  class ClientsController < AdminInterfaceController

    def connect_as
      @client = Client.find(params[:id])
      sign_in(:client, @client)
      redirect_to root_path
    end

  end
end
