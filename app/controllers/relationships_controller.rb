class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  respond_to :html

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    flash[:success] = "You are now following #{@user.name}!"
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    flash[:warning] = "You are no longer following #{@user.name}."
    respond_with @user
  end
end