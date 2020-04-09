class Transaction < ApplicationRecord
  before_create :approve_transaction

  scope :twenty_most_valuable -> { where(insertion_date: nil).order(:amount).limit(20) }

  def approve_transaction
    balance = self.where(sended_id: id).sum(:amount)
    return false if balance < amount
    true
  end
end