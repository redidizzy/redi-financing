class FriendshipsController < ApplicationController

  def create 
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save 
      flash[:notice] = "You have added #{friend.full_name} as a friend."
    else
      flash[:alert] = "There was something wrong with your request"
    end
    redirect_to my_friends_path

  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    friendship.destroy
    flash[:notice] = "You have unfriended #{friend.full_name} successfully"
    redirect_to my_friends_path
  end

end