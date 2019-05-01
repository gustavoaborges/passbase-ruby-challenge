class Transaction < ApplicationRecord
  include AASM

  aasm do
    state :requested, initial: true
    state :approved
    state :failed

    event :approve do
      transitions from: :requested, to: :approved
    end

    event :fail do
      transitions from: :requested, to: :failed
    end
  end

  belongs_to :sender
  belongs_to :receiver

  monetize :original_amount_cents
  monetize :transfered_amount_cents
end
