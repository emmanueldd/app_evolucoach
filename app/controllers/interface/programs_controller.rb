module Interface
  class ProgramsController < InterfaceController

    def show
      @program = current_client.programs.friendly.find(params[:id])
      @program_steps = @program.program_steps.order(:exercise_category_id)
    end

  end
end
