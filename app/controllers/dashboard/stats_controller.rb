module Dashboard
  class StatsController < DashboardController

    def index
      # Conversion = Prendre le nombre de leads à cette date, et le nombre de client à cette date et les diviser sur 2 requêtes différentes.
      # Transformation = Nombre de user_has_clients / nombre de user_has_clients (has_buy: true)
      date = params[:date] if params[:date.present?]
      date ||= Date.today
      period = date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day

      @visits = current_user.user_has_clients.where(created_at: period).count
      @clients_count = current_user.user_has_clients.clients.where(created_at: period).count

      @orders_paid = current_user.orders.paid.where(paid_at: period)
      @purchasers = @orders_paid.count


      # @income_by_month = current_user.stats.where(
      #   name: 'income',
      #   period: Date.today.beginning_of_year..Date.today
      # ).group_by_month(:period).pluck(:period, :stat_value)


      @income_by_month = Stat.where(
        name: 'income',
        period: Date.today.beginning_of_year..Date.today
      ).group_by_month { |u| u.period }.map { |k, v| [k.strftime("%B"), v.map { |ar| ar.stat_value }.sum ] }.to_h

    end

    def traffic
      @clients = Client.where(id: current_user.user_has_clients.clients.ids)
      @paying_clients = Client.where(id: current_user.user_has_clients.paying_clients.ids)
    end

    def goal

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
