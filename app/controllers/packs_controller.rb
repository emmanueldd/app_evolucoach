class PacksController < ApplicationController

  def show
    @pack = Pack.find_by(id: params[:id])
    @order = Order.new
  end

end
