class User < ApplicationRecord
  after_create :on_create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sender_transactions, class_name: 'Transaction', foreign_key: :sender_id
  has_many :receiver_transactions, class_name: 'Transaction', foreign_key: :receiver_id

  def on_create
    if (email != Rails.configuration.greeter_email)
      g = User.find_by(email: Rails.configuration.greeter_email)
      return nil unless g.present?
      svc = TransactionCreator.new
      svc.perform!(g, self, Money.new(100000, 'USD'))
    end
  end

  def transactions(status=nil)
    q = Transaction.where('sender_id = ? OR receiver_id = ?', id, id)
    q = q.where(status: status) if status.present?
    q.order(:created_at)
  end

  def balance(currency, pending_debits=false)
    # This could be converted to a calculation between 2 sub queries or a really complex CASE/WHEN
    debits = sender_transactions
              .where(original_amount_currency: currency)
    if(pending_debits)
      debits = debits.where(status: [Transaction::STATE_APPROVED, Transaction::STATE_REQUESTED])
    else
      debits = debits.where(status: Transaction::STATE_APPROVED)
    end

    credits = receiver_transactions
                .where(transfered_amount_currency: currency)
                .where(status: Transaction::STATE_APPROVED)

    Money.new(credits.sum(:transfered_amount_cents) - debits.sum(:original_amount_cents), currency)
  end

  def currencies_in_balance
    receiver_transactions.where(status: Transaction::STATE_APPROVED).uniq.pluck(:transfered_amount_currency)
  end

end
