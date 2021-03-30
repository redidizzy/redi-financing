class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end
  def my_friends 
    @current_user_friends = current_user.friends
  end
  def search
    if params[:keyword].present?
      @friends = User.search(params[:keyword])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "No friend '#{params[:keyword]}' has been found"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a keyword to search"
        format.js { render partial: 'users/friend_result' }
      end
    end
    
  end
end
