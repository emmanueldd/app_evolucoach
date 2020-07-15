class ClientsController < InterfaceController
  skip_before_action :authenticate_client!

  def authenticate_client
    if params[:step] == 'AddToCart' # || params[:step] == 'Lead'
      tracker do |t|
        t.facebook_pixel :track, { type: params[:step] }
      end
    end
  end

end
