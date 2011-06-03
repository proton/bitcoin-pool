class User < ActiveRecord::Base
  # Devise properties for user sign-up/sign-in/etc.
  devise :database_authenticatable,
    :confirmable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable

  # Workers belonging to this user
  has_many :workers,
    :dependent => :destroy

  # Blocks solved by this user
  # TODO : Rework this accessor to go through contributions
  has_many :blocks,
    :through => :workers

  # A user must have a nick which will be used to build worker usernames
  validates :nick,
    :presence => true,
    :uniqueness => true,
    :length => { :minimum => 4 }
end
