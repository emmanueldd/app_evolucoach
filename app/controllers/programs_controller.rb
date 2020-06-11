class ProgramsController < ApplicationController

  def show
    begin
      @program = Program.friendly.find(params[:id])
    rescue
      return redirect_back(fallback_location: root_path) if @program.blank?
    end
    @order = Order.new
    cookies[:last_important_object_visited] = @program.class.name
    cookies[:last_important_id_visited] = @program.id
  end

end
