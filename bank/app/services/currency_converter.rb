class CurrencyConverter
  def perform(amount, curr)
    rate = amount.bank.get_rate(amount.currency, curr)
    rate = 1 unless rate.present?
    Money.new(amount.cents * rate, curr)
  end
end
