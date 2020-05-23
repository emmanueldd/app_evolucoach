class ProgramsController < ApplicationController

  def show
    begin
      @program = Program.friendly.find(params[:id])
    rescue
      return redirect_back(fallback_location: root_path) if @program.blank?
    end
    @order = Order.new
  end

end
