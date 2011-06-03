class Payment < ActiveRecord::Base
  default_scope order("created_at DESC")

  belongs_to :user

  validates :address,
    :presence => true,
    :bitcoin_address => true

  validates :transaction_id,
    :presence => true

  validates :amount,
    :presence => true
end
