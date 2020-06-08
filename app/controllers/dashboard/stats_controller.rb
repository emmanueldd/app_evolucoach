module Dashboard
  class StatsController < DashboardController

    def index
      @date = params[:date].to_date if params[:date].present?
      @date ||= Date.today
      period = @date.beginning_of_month.beginning_of_day..@date.end_of_month.end_of_day

      begin
        @visits_count = current_user.user_has_clients.where(created_at: period).count
        @clients_count = current_user.user_has_clients.clients.where(created_at: period).count

        @orders_paid = current_user.orders.paid.where(paid_at: period)
        @purchases = @orders_paid.count

        @conversion = ((@clients_count.to_f / @visits_count.to_f) * 100).to_i
        @transformation = ((@purchases.to_f / @clients_count.to_f) * 100).to_i
        # @transformation = ((9.to_f / 10.to_f) * 100).to_i

        @conversion_diff = 100 - @conversion
        @transformation_diff = 100 - @transformation
      rescue
        # nothing
        @transformation ||= 0
        @conversion ||= 0
      end
      # @income_by_month = Stat.where(
      #   name: 'income',
      #   period: Date.today.beginning_of_year..Date.today
      # ).group_by_month { |u| u.period }.map { |k, v| [k.strftime("%B"), v.map { |ar| ar.stat_value }.sum ] }.to_h
    end

    def get_charts(date = Date.today)
      period_time = (date - 7.months)..date.end_of_month
      period_time2 = (date - 1.year - 7.months)..(date - 1.year)
      render json: {
        data1: current_user.stats.where(name: 'income', period: period_time).pluck(:stat_value),
        data2: current_user.stats.where(name: 'income', period: period_time2).pluck(:stat_value)
      }
    end


    def traffic
      begin
        @clients = Client.where(id: current_user.user_has_clients.clients.ids)
        @paying_clients = Client.where(id: current_user.user_has_clients.paying_clients.ids)

        @clients_18_24 = (@clients.where(birth_date: (Date.today - 24.years).beginning_of_year..(Date.today - 18.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @clients_25_34 = (@clients.where(birth_date: (Date.today - 34.years).beginning_of_year..(Date.today - 25.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @clients_35_44 = (@clients.where(birth_date: (Date.today - 44.years).beginning_of_year..(Date.today - 35.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @clients_45_54 = (@clients.where(birth_date: (Date.today - 54.years).beginning_of_year..(Date.today - 45.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @clients_55 = (@clients.where(birth_date: (Date.today - 100.years).beginning_of_year..(Date.today - 55.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @men_clients = (@clients.men.count.to_f / @clients.count.to_f * 100).to_i
        @women_clients = (@clients.women.count.to_f / @clients.count.to_f * 100).to_i

        @clients_by_city = @clients.all.group(:city).count

        @paying_clients_18_24 = (@clients.where(birth_date: (Date.today - 24.years).beginning_of_year..(Date.today - 18.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @paying_clients_25_34 = (@clients.where(birth_date: (Date.today - 34.years).beginning_of_year..(Date.today - 25.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @paying_clients_35_44 = (@clients.where(birth_date: (Date.today - 44.years).beginning_of_year..(Date.today - 35.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @paying_clients_45_54 = (@clients.where(birth_date: (Date.today - 54.years).beginning_of_year..(Date.today - 45.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @paying_clients_55 = (@clients.where(birth_date: (Date.today - 100.years).beginning_of_year..(Date.today - 55.years).end_of_year).count.to_f / @clients.count.to_f * 100).to_i

        @men_paying_clients = (@paying_clients.men.count.to_f / @paying_clients.count.to_f * 100).to_i

        @women_paying_clients = (@paying_clients.women.count.to_f / @paying_clients.count.to_f * 100).to_i

        @paying_clients_by_city = @paying_clients.all.group(:city).count
      rescue
        # nothing
      end
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
