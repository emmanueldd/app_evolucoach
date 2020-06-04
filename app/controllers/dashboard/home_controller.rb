module Dashboard
  class HomeController < DashboardController

    def index
      @profile_home = true
      date = params[:date] if params[:date.present?]
      date ||= Date.today
      period = date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day
      @orders_paid = current_user.orders.paid.where(paid_at: period)
    end

  end
end
