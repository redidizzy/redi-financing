class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks 
  
  validates :name, :ticker, presence: true


  def self.lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:publishable_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin 
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception 
      nil
    end
  end
end
