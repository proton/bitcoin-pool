class User < ActiveRecord::Base
  # Devise properties for user sign-up/sign-in/etc.
  devise :database_authenticatable,
    :confirmable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable

  # Used to authenticate users indifferently against their 
  # e-mail address or their nickname
  attr_accessor :account

  # Workers belonging to this user
  has_many :workers,
    :dependent => :destroy

  # Contributions toward solving a block (scoring for a round)
  has_many :contributions,
    :through => :workers

  # Periodically recorded statistics
  has_many :statistics,
    :dependent => :destroy

  # Payments made to this user
  has_many :payments,
    :dependent => :destroy

  # A user must have a nick which will be used to build worker usernames
  validates :nick,
    :presence => true,
    :uniqueness => true,
    :length => { :minimum => 4 }

  # A bitcoin address is necessary for payments
  validates :address,
    :presence => true,
    :bitcoin_address => true,
    :uniqueness => true

  validates :payment_treshold,
    :numericality => {
      :greater_than_or_equal_to => 0.1,
      :less_than => 10000
    },
    :presence => true

  # Useful for display in admin interface
  def to_label
    nick
  end

  # Total balance available to this user
  def total_balance(confirmed = true)
    balance(confirmed) - payments.sum(:amount)
  end

  # Balance from regular pooled mining
  def balance(confirmed = true)
    contributions.confirmed(confirmed).sum(:amount)
  end

  # Pays users if necessary
  def self.pay!
    User.all.each do |user|
      if user.total_balance > user.payment_treshold
        user.payments.create!({
            :amount => ((user.total_balance * 100).truncate / 100.0),
            :address => user.address
          }
        )
      end
    end
  end

  
  protected

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      acct = conditions.delete(:account)
      where(conditions).where(["nick = :value OR email = :value", { :value => acct }]).first
    end
end
