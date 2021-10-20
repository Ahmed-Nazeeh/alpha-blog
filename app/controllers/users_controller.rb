class UsersController < ApplicationController
    before_action :set_user, only: [:show , :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def new
        @user = User.new
    end

    def index
        @users = User.all
        @users = User.paginate(page: params[:page], per_page: 2)
    end

    def show
        #@user = User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 2)
        
    end

    def create
        #byebug
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user_id
            flash[:notice] = "welcome to the Alpha Blog #{@user.username} you have succefully signed up"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:alert] = "Account and all associated articles are succefully deleted"
        redirect_to articles_path
    end

    def edit
        #@user = User.find(params[:id])
    end

    def update
        #@user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "your account information was successfully updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "you can only edit or delete your own account"
            redirect_to @user
        end
    end
end