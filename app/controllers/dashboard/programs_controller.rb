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
      redirect_to edit_dashboard_program_path(@program) if @program.save!
    end

    def show
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
      redirect_to dashboard_programs_path if @program.destroy
    end

    private
      def program_params
        params.require(:program).permit(:name, :client, :description, :price, :frequency, :duration, :cover, :published, :info_note, :rest_note)
      end

      def set_program
        @program = current_user.programs.friendly.find(params[:id])
      end
  end
end
