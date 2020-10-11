module Dashboard
  class OnlineOffersController < DashboardController
    before_action :set_online_offer, only: [:show, :edit, :update, :destroy]

    def index
      set_profile_box
      @online_offers = current_user.online_offers.published
    end

    def new
      @online_offer = current_user.online_offers.new
    end

    def create
      @online_offer = current_user.online_offers.new(online_offer_params)
      if online_offer_params[:user_has_client_id].present?
        @user_has_client = current_user.user_has_clients.find(online_offer_params[:user_has_client_id])
        @online_offer.user_has_client = @user_has_client if @user_has_client.present?
      end
      redirect_to edit_dashboard_online_offer_path(@online_offer) if @online_offer.save!
    end

    def show
      if @online_offer.user_has_client.present?
        @back_path = dashboard_crm_path(@online_offer.user_has_client, section: 'online_offers')
      else
        @back_path = dashboard_online_offers_path
      end
    end

    def edit
    end

    def update
      if @online_offer.update(online_offer_params)
        if params[:online_offer][:next_step].present?
          redirect_to edit_dashboard_online_offer_path(step: params[:online_offer][:next_step])
        else
          redirect_to dashboard_online_offers_path, notice: 'Votre catalogue d\'offres a été mis à jour.'
        end
      end
    end

    def destroy
      redirect_back(fallback_location: dashboard_online_offers_path, notice: 'Programme supprimé') if @online_offer.destroy
    end

    private
      def online_offer_params
        params.require(:online_offer).permit(:name, :client, :description, :price,  :cover, :published, :user_has_client_id)
      end

      def set_online_offer
        @online_offer = current_user.online_offers.friendly.find(params[:id])
      end
  end
end
