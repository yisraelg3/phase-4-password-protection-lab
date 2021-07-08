class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        # byebug
        # if user.password == params[:password]
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: 201
        else
            render json: {error: "Wrong username or password"}, status: 401
        end
    end

    def destroy
        session.delete :user_id
        head :no_content
    end
end
