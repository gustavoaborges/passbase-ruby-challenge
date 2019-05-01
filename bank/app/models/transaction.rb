class Transaction < ApplicationRecord
  include AASM

  aasm(:status) do
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

  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'

  monetize :original_amount_cents
  monetize :transfered_amount_cents
end
