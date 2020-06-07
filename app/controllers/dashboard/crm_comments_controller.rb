module Dashboard
  class CrmCommentsController < DashboardController
    before_action :set_user_has_client, only: [:new, :create, :show, :update, :destroy]
    before_action :set_crm_comment, only: [:show, :edit, :update, :destroy]

    def edit
      @user_has_client = @crm_comment.user_has_client
    end

    def new
      @crm_comment = current_user.crm_comments.new(user_has_client: @user_has_client)
    end

    def create
      @crm_comment = current_user.crm_comments.new(crm_comment_params)
      @crm_comment.user_has_client = @user_has_client
      @crm_comment.published = true
      if @crm_comment.save!
        redirect_to dashboard_crm_path(@user_has_client, section: 'followup')
      end
    end

    def update
      @user_has_client = @crm_comment.user_has_client
      @crm_comment.assign_attributes(crm_comment_params)
      @crm_comment.published = true
      if @crm_comment.save!
        redirect_to dashboard_crm_path(@user_has_client, section: 'followup')
      end
    end

    def destroy
      @user_has_client = @crm_comment.user_has_client
      if @crm_comment.update(archived: true)
        redirect_to dashboard_crm_path(@user_has_client, section: 'followup'), notice: 'Note supprimée.'
      end
    end

    private
      def crm_comment_params
        params.require(:crm_comment).permit(:name, :comment)
      end
      def set_user_has_client
        @user_has_client = UserHasClient.find_by(id: params[:crm_id])
      end

      def set_crm_comment
        @crm_comment = current_user.crm_comments.find(params[:id])
      end
  end
end
