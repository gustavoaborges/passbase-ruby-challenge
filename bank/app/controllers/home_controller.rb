class HomeController < ApplicationController
  before_action :authenticate_user!
  helper_method :balance,
                :transactions

  def balances
    @balances ||= begin
      blcs = {}
      current_user.currencies_in_balance.each do |cur|
        blcs[cur] = current_user.balance(cur)
      end
      blcs
    end
  end

  def transactions
    current_user.transactions.page(params[:page] || 1)
  end
end
