module Dashboard
  class StatsController < DashboardController

    def index
      # @stats = current_user.stats
    end

    def traffic

    end

    # def index
    #   @stat = Stat.new(params[:start_date], params[:end_date], params[:place_id])
    #   if params[:stat_slug].present?
    #     render json: { "#{params[:stat_slug]}": @stat.send(params[:stat_slug], params[:page])}
    #   else
    #     stats = {}
    #     (Stat.instance_methods - Object.methods).each do |method_name|
    #       stats["#{method_name}"] = @stat.send(method_name)
    #     end
    #     render json: stats
    #   end
    # end

  end
end
