class Worker < ActiveRecord::Base
  # A worker always belongs to an account
  belongs_to :user

  # It might have contributed to solving one or more blocks
  has_many :contributions,
    :dependent => :destroy

  attr_accessor :suffix, 
    :current_shares, 
    :last_share_at, 
    :found_blocks

  # It should be possible to read a workers current hashrate
  attr_reader :hashrate

  # A worker has many submitted shares
  has_many :shares,
    :foreign_key => "username",
    :primary_key => "username",
    :dependent => :destroy

  # It should always have a username (nick.suffix)
  validates :username,
    :presence => true,
    :uniqueness => true

  # It should always have a suffix
  validates :suffix,
    :presence => true,
    :length => { :minimum => 4 }

  # It needs a password, we validate a minimum length to avoid possible
  # problems with pushpool
  validates :password,
    :presence => true,
    :length => { :minimum => 4 }

  # The shares submitted by this worker during the current round
  def current_shares
    shares.count
  end

  # The moment at which the last share was submitted
  def last_share_at
    shares.maximum(:created_at)
  end

  # The blocks actually solved by this worker
  def found_blocks
    shares.where(:upstream_result => "Y").count + contributions.where(:found_block => true).count
  end

  # The amount of stale shares submitted
  def stale_shares
    shares.stale.count
  end

  # The hashrate in H/s averaged on the last 10 minutes
  def hashrate
    7158278.826666666 * shares.fresh.count
  end

  # Global count of workers having submitted at least a share during
  # the last 10 minutes
  def self.recently_active(limit = DateTime.now.advance(:minutes => -10))
    where("EXISTS (SELECT * FROM `shares` WHERE `shares`.`username` = `workers`.`username` AND `shares`.`created_at` > ?)", limit).count
  end

  # suffix reader
  def suffix
    username.match(/[^\.]*$/)[0] unless username.blank?
  end

  # suffix writer
  def suffix=(str)
    self.username = "#{user.nick}.#{str}"
  end
end
