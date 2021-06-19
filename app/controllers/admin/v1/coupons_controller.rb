module Admin::V1
  class CouponsController < ApiController
    before_action :load_coupon, only: %i[update destroy]
    def index
      if params['coupon'] != {}
        @coupon = Coupon.new
        @coupon.attributes = coupon_params
        render :show
      else
        @coupons = Coupon.all
      end
    end
    
    def create
      @coupon = Coupon.new
      @coupon.attributes = coupon_params
      save_coupon!
    end

    def update
      @coupon.attributes = coupon_params
      save_coupon!
    end

    def destroy
      @coupon.destroy
    end

    private

    def load_coupon
      @coupon = Coupon.find(params[:id])
    end

    def save_coupon!
      @coupon.save!
      render :show
    rescue
      render_error(fields: @coupon.errors.messages)
    end

    def coupon_params
      return {} unless params.has_key?(:coupon)
      params.require(:coupon).permit(:code, :status, :due_date, :discount_value)
    end

  end
end