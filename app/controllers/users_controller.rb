class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        #byebug
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "welcome to the Alpha Blog #{@user.username} you have succefully signed up"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end