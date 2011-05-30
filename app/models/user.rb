class User < ActiveRecord::Base
  devise :database_authenticatable,
    :confirmable,
    :registerable,
    :recoverable, 
    :rememberable, 
    :trackable, 
    :validatable
  
  validates :nick,
    :presence => true,
    :uniqueness => true,
    :length => { :minimum => 4 }
end
