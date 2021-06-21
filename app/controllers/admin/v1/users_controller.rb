module Admin::V1
  class UsersController < ApiController
    before_action :load_user, only: [:show, :update, :destroy]

    def index
      if params.has_key?(:search)
        scope_without_current_user = User.where.not(id: @current_user.id)
        if params.has_key?(:pagination)
          page = params['pagination']['page']
          length = params['pagination']['length']
          page_to_multiply = (page.to_i-1)*length.to_i
          @users = scope_without_current_user.search_by_name(params['search']['name'])[page_to_multiply..page_to_multiply+length.to_i-1]
        else
          @users = scope_without_current_user.search_by_name(params['search']['name'])[0..9]
        end
      else
        scope_without_current_user = User.where.not(id: @current_user.id)
        if params.has_key?(:pagination)
          page = params['pagination']['page']
          length = params['pagination']['length']
          page_to_multiply = (page.to_i-1)*length.to_i
          @users = scope_without_current_user[page_to_multiply..page_to_multiply+length.to_i-1]
        else
          @users = scope_without_current_user[0..9]
        end
      end
    end

    def create
      @user = User.new
      @user.attributes = user_params
      save_user!
    end

    def update
      @user.attributes = user_params
      save_user!
    end

    def show; end

    def destroy
      @user.destroy!
    rescue
      render_error(fields: @user.errors.messages)
    end

    private

    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      return {} unless params.has_key?(:user)
      params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :profile)
    end

    def save_user!
      @user.save!
      render :show
    rescue
      render_error(fields: @user.errors.messages)
    end
  end
end