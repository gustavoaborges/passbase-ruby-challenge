class TransactionCreator

  ALLOWED_CURRENCIES = [
    'USD',
    'EUR',
    'GBP'
  ]

  def perform!(from_user, to_user, amount)
    throw Money::Currency::UnknownCurrency unless amount.currency.iso_code.in?(ALLOWED_CURRENCIES)

    # target_currency = amount.currency unless target_currency.present?
    # target_amount = currency_conversion(amount, target_currency)
    original_amount = select_balance(from_user, amount)

    # balance = from_user.balance(amount.currency.iso_code, pending_debits=true)
    t = Transaction.create!(sender: from_user, receiver: to_user, original_amount: original_amount || amount,
                              transfered_amount: amount)
    if(from_user.email == 'greetings@passbase.com' || original_amount.present?)
      t.approve!
    else
      t.fail!
    end
    t
  end

  private

  # Checks which balance has enough funds to make the transfers
  def select_balance(user, amount)
    balance = user.balance(amount.currency.iso_code, pending_debits=true)
    if (balance >= amount)
      return amount
    end
    user.currencies_in_balance.each do |curr|
      next if(curr == amount.currency.iso_code)
      balance = user.balance(curr, pending_debits=true)

      if(currency_conversion(balance, amount.currency.iso_code) >= amount)
        return currency_conversion(amount, curr)
      end
    end
    return nil
  end

  def currency_conversion(amount, dest_curr)
    return amount unless amount.currency.iso_code != dest_curr
    svc = CurrencyConverter.new
    svc.perform(amount, dest_curr)
  end

end
