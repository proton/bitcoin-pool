class Payment < ActiveRecord::Base
  default_scope order("created_at DESC")

  belongs_to :user

  before_validation :perform_payment,
    :on => :create

  validates :address,
    :presence => true,
    :bitcoin_address => true

  validates :transaction_id,
    :presence => true

  validates :amount,
    :presence => true,
    :numericality => {
      :greater_than_or_equal_to => 0.1
    }

  
  private

    # Generates the bitcoin payment
    def perform_payment
      self.transaction_id = bitcoin.send_to_address(address, amount.to_f)
    end
end
