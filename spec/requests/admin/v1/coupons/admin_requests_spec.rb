require 'rails_helper'

RSpec.describe "Admin::V1::Coupons as :admin", type: :request do
  let(:login_user) {create :user}

  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 5) }
    
    context "with valid params" do
      let(:coupon_params) { {coupon: attributes_for(:coupon)}.as_json }
    
      it "returns all Coupons" do
        get url, headers: auth_header(login_user)
        expect(body_json['coupons']).to contain_exactly *coupons.as_json(only: %i[code status discount_value due_date])
      end
      
      it "returns specific coupon" do
        get url, headers: auth_header(login_user), params: coupon_params
        coupon_params['coupon']['discount_value'] = "#{coupon_params['coupon']['discount_value']}.0"
        expect(body_json['coupon']).to contain_exactly *coupon_params['coupon'].as_json()
      end
      
      it "returns success status" do
        get url, headers: auth_header(login_user)
        expect(response).to have_http_status(:ok)
      end
      
    end

    context "with invalid params" do
      let(:coupon_invalid_params) do 
        {coupon: attributes_for(:coupon, code: nil)}.to_json
      end
      
      it "doesn't return specific coupon" do
        get url, headers: auth_header(login_user), params: coupon_invalid_params
        p body_json
        expect(body_json['coupon']).to be_nil
      end
      
      it 'returns error messages' do
        post url, headers: auth_header(login_user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('code')
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(login_user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
    end
    
  end
  
  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }
  
    context "with valid params" do
      let(:coupon_params) { {coupon: attributes_for(:coupon)}.to_json }
      it "adds new Coupon" do
        expect do
          post url, headers: auth_header(login_user), params: coupon_params
          p body_json
        end.to change(Coupon, :count).by(1)
      end

      it "returns success status" do
        get url, headers: auth_header(login_user)
        expect(response).to have_http_status(:ok)
      end
    end
    
    context "with invalid params" do
      let(:coupon_invalid_params) do 
        {coupon: attributes_for(:coupon, code: nil)}.to_json
      end
        it "doesn't add a new Coupon" do
        expect do
          post url, headers: auth_header(login_user), params: coupon_invalid_params
          p body_json
        end.to_not change(Coupon, :count)
      end
      it 'returns error messages' do
        post url, headers: auth_header(login_user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('code')
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(login_user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # context "PATCH /coupons" do
    
  #   it "updates coupon due_date" do
      
  #   end

  #   it "updates coupon status" do
      
  #   end

  #   it "updates coupon discount_value" do
      
  #   end

  # end
end
