class PacksController < ApplicationController

  def show
    store_user_location!
    @pack = Pack.find_by(id: params[:id])
    @order = Order.new
    cookies[:last_important_object_visited] = @pack.class.name
    cookies[:last_important_id_visited] = @pack.id
  end

end
