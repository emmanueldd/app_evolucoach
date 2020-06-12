module Dashboard
  class PacksController < DashboardController
    before_action :set_pack, only: [:show, :edit, :update, :destroy]
    def index
      @packs = current_user.packs.published
    end

    def new
      @pack = current_user.packs.new
    end

    def create
      @pack = current_user.packs.new(pack_params)
      redirect_to edit_dashboard_pack_path(@pack) if @pack.save!
    end

    def show
      @pack_steps = @pack.pack_steps.order(:exercise_category_id)
    end

    def edit
    end

    def update
      if @pack.update(pack_params)
        if params[:pack][:next_step].present?
          redirect_to edit_dashboard_pack_path(step: params[:pack][:next_step])
        else
          redirect_to [:dashboard, current_user], notice: 'Pack enregistré'
        end
      end
    end

    def destroy
      redirect_back(fallback_location: [:dashboard, current_user], notice: 'Pack supprimé') if @pack.destroy
    end

    private
      def pack_params
        params.require(:pack).permit(:pack_type, :name, :unit_price, :nb_of_courses, :description, :published)
      end

      def set_pack
        @pack = current_user.packs.find(params[:id])
      end
  end
end
