class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships

  def stock_already_tracked?(ticker)
    stocks.where(ticker: ticker).exists?
  end

  def under_stock_limit?(limit)
    stocks.count < limit
  end
  def can_track_stock?(ticker)
    under_stock_limit?(10) and !stock_already_tracked?(ticker)
  end
  def full_name
    return "#{first_name} #{last_name}" if first_name or last_name
    "Anonymous"
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end
  def self.first_name_matches(param)
    matches('first_name', param)
  end
  def self.last_name_matches(param)
    matches('last_name', param)
  end
  def self.email_matches(param)
    matches('email', param)
  end
  

  def self.search(param)
    param.strip!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def except_current_user(users)
    users.reject  { |user| user.id == self.id }
  end
end
