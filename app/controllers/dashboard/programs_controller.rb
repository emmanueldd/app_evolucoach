module Dashboard
  class ProgramsController < DashboardController
    before_action :set_program, only: [:show, :edit, :update, :destroy]

    def index
      set_profile_box
      @programs = current_user.programs.published
    end

    def new
      @program = current_user.programs.new
    end

    def create
      @program = current_user.programs.new(program_params)
      if program_params[:user_has_client_id].present?
        @user_has_client = current_user.user_has_clients.find(program_params[:user_has_client_id])
        @program.user_has_client = @user_has_client if @user_has_client.present?
      end
      redirect_to edit_dashboard_program_path(@program) if @program.save!
    end

    def show
      if @program.user_has_client.present?
        @back_path = dashboard_crm_path(@program.user_has_client, section: 'programs')
      else
        @back_path = dashboard_programs_path
      end
      @program_steps = @program.program_steps.order(:exercise_category_id)
    end

    def edit
    end

    def update
      if @program.update(program_params)
        if params[:program][:next_step].present?
          if params[:program][:next_step] == 'back'
            redirect_to dashboard_program_step_index_path(@program),
            notice: 'Modification enregistrée'
          else
            redirect_to edit_dashboard_program_path(step: params[:program][:next_step])
          end
        else
          redirect_to dashboard_program_path(@program)
        end
      end
    end

    def destroy
      redirect_back(fallback_location: dashboard_programs_path, notice: 'Programme supprimé') if @program.destroy!
    end

    private
      def program_params
        params.require(:program).permit(:name, :client, :description, :price, :frequency, :duration, :cover, :published, :info_note, :rest_note, :user_has_client_id, :file, :show_calendly_before_payment, :show_calendly_after_payment, :hide_payment_page, user_attributes: [:id, :calendly_url])
      end

      def set_program
        @program = current_user.programs.friendly.find(params[:id])
      end
  end
end
