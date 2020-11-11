module Dashboard
  class StripePaymentMethodsController < DashboardController

    def create
      @stripe_payment_method = current_user.stripe_payment_methods.new(stripe_payment_method_params)
      if @stripe_payment_method.save
        render json: { stripe_payment_method: @stripe_payment_method }
      else
        render json: { errors: @stripe_payment_method.errors }
      end
    end

    def update
      @stripe_payment_method = current_user.stripe_payment_methods.find_by(id: params[:id])
      if @stripe_payment_method.present?
        if @stripe_payment_method.update!(stripe_payment_method_params)
          render json: { stripe_payment_method: @stripe_payment_method }
        else
          render json: { errors: @stripe_payment_method.errors }
        end
      else
        render json: { errors: :stripe_payment_method_not_found }
      end
    end

    def index
      @stripe_payment_methods = current_user.stripe_payment_methods
      if @stripe_payment_methods.present?
        render json: { stripe_payment_methods: @stripe_payment_methods }
      else
        render json: { errors: :no_stripe_payment_methods_attached_to_user }
      end
    end

    def show
      @stripe_payment_method = current_user.stripe_payment_methods.find_by(id: params[:id])
      if @stripe_payment_method
        render json: { stripe_payment_method: @stripe_payment_method }
      else
        render json: { errors: :stripe_payment_method_not_found }
      end
    end

    def destroy
      @stripe_payment_method = current_user.stripe_payment_methods.find_by(id: params[:id])
      if @stripe_payment_method.present?
        if @stripe_payment_method.destroy!
          render json: { destroyed: true }
        else
          render json: {
            errors: :could_not_destroy_this_stripe_payment_method,
            destroyed: false
          }
        end
      else
        render json: {
          errors: :stripe_payment_method_not_found,
          destroyed: false
        }
      end
    end



    private
      def stripe_payment_method_params
        params.permit(:stripe_payment_method_id, :favorite)
      end

  end
end
