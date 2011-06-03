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

  # Payments made to this user
  has_many :payments,
    :dependent => :destroy

  # Blocks solved by this user
  # TODO : Rework this accessor to go through contributions
#  has_many :blocks,
#    :through => :workers

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

  # Useful for display in admin interface
  def to_label
    nick
  end

  protected

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      acct = conditions.delete(:account)
      where(conditions).where(["nick = :value OR email = :value", { :value => acct }]).first
    end
end
