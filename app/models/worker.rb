class Worker < ActiveRecord::Base
  belongs_to :user

  has_many :blocks,
    :dependent => :nullify

  attr_accessor :suffix, 
    :current_shares, 
    :last_share_at, 
    :found_blocks

  attr_reader :hashrate
  
  has_many :shares,
    :foreign_key => "username",
    :primary_key => "username"
  
  validates :username,
    :presence => true,
    :uniqueness => true
  
  validates :suffix,
    :presence => true,
    :length => { :minimum => 4 }
  
  validates :password,
    :presence => true
  
  def current_shares
    shares.count
  end
  
  def last_share_at
    shares.maximum(:created_at)
  end
  
  def found_blocks
    shares.where(:upstream_result => "Y").count
  end
  
  def stale_shares
    shares.stale.count
  end

  def hashrate
    7158278.826666666 * shares.fresh.count
  end

  def self.recently_active(limit = DateTime.now.advance(:minutes => -10))
    where("EXISTS (SELECT * FROM `shares` WHERE `shares`.`username` = `workers`.`username` AND `shares`.`created_at` > ?)", limit).count
  end
  
  def suffix
    username.match(/[^\.]*$/)[0] unless username.blank?
  end
  
  def suffix=(str)
    self.username = "#{user.nick}.#{str}"
  end
end
