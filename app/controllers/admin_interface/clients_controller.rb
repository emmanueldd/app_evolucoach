module AdminInterface
  class ClientsController < AdminInterfaceController

    def connect_as
      @client = Client.find(params[:id])
      sign_in(:client, @client)
      redirect_to interface_root_path
    end

  end
end
