module Dashboard
  class ProgramStepsController < DashboardController
    before_action :set_program, only: [:index, :new, :create]
    before_action :set_program_step, only: [:show, :edit, :update, :destroy]

    def index
      @program_steps = @program.program_steps
      @program_step = current_user.program_steps.new
      @exercise_categories = ExerciseCategory.published
    end

    def new
      @program_step = current_user.program_steps.new
    end

    def create
      @program_step = current_user.program_steps.new(program_step_params)
      @program_step.program = @program
      redirect_to edit_dashboard_step_path(@program_step) if @program_step.save!
    end

    def show
    end

    def edit
    end

    def update
      if @program_step.update(program_step_params)
        if params[:program_step][:next_step].present?
          redirect_to edit_dashboard_program_step_path(step: params[:program_step][:next_step])
        else
          @program = @program_step.program
          redirect_to [:dashboard, @program], notice: 'Programme mis à jour'
        end
      end
    end

    def destroy
      redirect_to dashboard_program_steps_path if @program_step.destroy
    end

    private
      def program_step_params
        params.require(:program_step).permit(:name, :published, :exercise_id, :round, :repetition, :cadence, :charge, :exercise_category_id)
      end

      def set_program
        @program = current_user.programs.find(params[:program_id])
      end

      def set_program_step
        @program_step = current_user.program_steps.find(params[:id])
      end
  end
end
