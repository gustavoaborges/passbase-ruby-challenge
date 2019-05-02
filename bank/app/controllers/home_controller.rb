class HomeController < ApplicationController
  before_action :authenticate_user!
  helper_method :balances,
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
    current_user.transactions.order(created_at: :desc).page(params[:page] || 1)
  end
end
