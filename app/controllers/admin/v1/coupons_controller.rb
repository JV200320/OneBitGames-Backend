module Admin::V1
  class CouponsController < ApiController

    def index
      if params['coupon'] != {}
        load_coupon
        render :show
      else
        @coupons = Coupon.all
      end
    end
    
    def create
      load_coupon
      save_coupon!
    end

    private

    def load_coupon
      @coupon = Coupon.new
      @coupon.attributes = coupon_params
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