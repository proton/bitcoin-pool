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
    :inclusion => { :in => [0.01..21000000] }

  
  private

    # Generates the bitcoin payment
    def perform_payment
      self.transaction_id = Bitcoin::Client.new.send_to_address(address, amount)
    end
end
