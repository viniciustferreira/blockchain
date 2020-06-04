class Transaction < ApplicationRecord
  validates :amount, with: :approve_transaction
  validates :sender_id, :receiver_id, with: :check_user

  scope :twenty_most_valuable, -> { where(insertion_date: nil).order(:amount).limit(20) }

  def approve_transaction
    balance = Transaction.where(sender_id: sender_id).sum(:amount)
    if balance < amount
      #TODO: create another way to share core value
      if User.find(sender_id)&.name == "core" 
        return true
      else
        errors.add(:balance, "not enough cash")
        return false 
      end
    end
    true
  end

  def check_user
    if User.where(id: sender_id).empty? || User.where(id: receiver_id).empty?
      errors.add(:user, "sender user or receiver user not found")
      return false 
    end
    true
  end

  def self.create_first_transaction
    core_user = User.find_by_name("core") || User.create_core_user

    create(sender_id: core_user.id,  receiver_id: core_user.id, amount: '99999999' )
  end

  def self.mark_transactions_as_clear(transactions)
    transactions.split(',').each do |transaction_id|
      transaction = self.find(transaction_id)
      transaction.update_attributes(insertion_date: DateTime.now)
    end
  end
end