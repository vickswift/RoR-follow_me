class UsersController < ApplicationController
  before_action :check_login

  def dash
    @user = User.find_by_id(params[:id])
    @friends = @user.friends
    @other_people = User.where.not(id: params[:id])
  end

  def follow
    Friendship.create(user: User.find_by_id(params[:user_id]), friend: User.find_by_id(params[:friend_id]))
    redirect_to "/dash/#{params[:user_id]}"
  end

  def unfollow
    Friendship.where(user_id: params[:user_id], friend_id: params[:friend_id]).first.destroy
    redirect_to "/dash/#{params[:user_id]}"
  end

  private

  def check_login
    if !session[:user_id]
      redirect_to '/'
    end
  end
end
