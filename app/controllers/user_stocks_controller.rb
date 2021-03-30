class UserStocksController < ApplicationController
  def create 
    stock = Stock.find_by(ticker: params[:ticker])
    if stock.blank?
      stock = Stock.lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create user:current_user, stock: stock
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end
end
