class OnlineOffersController < ApplicationController

  def show
    store_user_location!
    begin
      @online_offer = OnlineOffer.friendly.find(params[:id])
    rescue
      return redirect_back(fallback_location: root_path) if @online_offer.blank?
    end
    @order = Order.new
    cookies[:last_important_object_visited] = @online_offer.class.name
    cookies[:last_important_id_visited] = @online_offer.id
  end

end
