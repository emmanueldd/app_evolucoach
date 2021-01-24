class ProgramsController < ApplicationController

  def show
    store_user_location!
    begin
      @program = Program.friendly.find(params[:id])
    rescue
      return redirect_back(fallback_location: root_path) if @program.blank?
    end
    @order = Order.new
    cookies[:last_important_object_visited] = @program.class.name
    cookies[:last_important_id_visited] = @program.id
  end

  def download
    if params[:secret_key].present? && params[:program_id].present?
      @program = Program.friendly.find(params[:program_id])
      redirect_to @program.file_url
    else
      redirect_to root_url
    end
  end

end
