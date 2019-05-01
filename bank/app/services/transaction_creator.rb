class TransactionCreator

  def perform(from_user, to_user, amount_cents, target_currency=nil)
    validate

    amount = Money.new(amount_cents, from_user.currency)
    target_currency = amount.currency unless target_currency.present?
    target_amount = currency_conversion(amount, target_currency)

    balance = from_user.balance(amount.currency, pending_debits=true)
    t = Transaction.create!(sender=from_user, receiver=to_user, original_amount=amount, transfered_amount=target_amount)
    if(balance >= amount)
      t.approve!
    else
      t.fail!
    end
  end

  private

  def currency_conversion(amount, dest_curr)
    return amount unless amount.currency != dest_curr
    svc = CurrencyConverter.new
    svc.perform(amount, dest_curr)
  end

  def validate
  end

end
