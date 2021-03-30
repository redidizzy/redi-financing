class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def stock_already_tracked?(ticker)
    stocks.where(ticker: ticker).exists?
  end

  def under_stock_limit?(limit)
    stocks.count < limit
  end
  def can_track_stock?(ticker)
    under_stock_limit?(10) and !stock_already_tracked?(ticker)
  end
end
