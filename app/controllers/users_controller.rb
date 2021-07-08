class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid
    def create
        new_user = User.create!(user_params)
        session[:user_id] = new_user.id
        render json: new_user
    end
    
    def show
        # byebug
        user = User.find(session[:user_id])
        render json: user 
    rescue ActiveRecord::RecordNotFound 
        render json: {errors: "Not authorized"}, status: :unauthorized
    end

    private 
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

    def invalid(i)
        render json: {error: i.record.errors.full_messages}, status: 422
    end
end
