class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :signed_out_user, only: [:new, :create]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      #flash[:success] = "Welcome to CPObaby!"
      #sign_in @user
      #redirect_to @user
      flash[:success] = "Thank you for registering! Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user # because the remember token gets reset when the user is saved
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    # 'unless current_user?(@user)' would prevent admin from deleting self, but not from deleting other admins
    unless @user.admin? # prevents deletion of admins (except from the console, of course)
      @user.destroy 
      flash[:success] = "User destroyed."
      redirect_to users_url
    else
      redirect_to root_url
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def confirm
    @user = User.find(params[:id])
    @code = params[:confirmation_code]
    if @user.confirmation_code == @code
      @user.update_attributes(activated: true)
      flash[:success] = "Account activated. Welcome to CPObaby!"
      sign_in @user
      redirect_to @user
    else
      flash[:warning] = "Incorrect account activation code."
      redirect_to root_url
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def signed_out_user
      redirect_to(root_url) unless !signed_in?
    end
end
