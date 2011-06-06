class Share < ActiveRecord::Base  
  # We want to deal with accepted shares unless otherwise specified
  default_scope where("our_result = 'Y'")

  # A share always belongs to a worker, we need to supply custom join
  # keys to match the DB structure pushpool is expecting
  belongs_to :worker,
    :foreign_key => "username",
    :primary_key => "username"

  # A share can be a winning solution for a block
  has_one :block

  # Filters on fresh shares
  def self.fresh(limit = DateTime.now.advance(:minutes => -10))
    where("created_at > ?", limit)
  end

  # Hashrate in H/s averaged on last 10 minutes (at diff. 1 each share
  # represents 2^32 hashes)
  def self.hashrate
    # => (fresh.count.to_f * 2**32 / (10 * 60))
    7158278.826666666 * fresh.count
  end

  # Scope returning only stale shares
  def self.stale
    with_exclusive_scope do
      where(:reason => "stale")
    end
  end

  # Scope returning shares that are not submitted by PPS workers
  def self.pps(should_pps = true)
    joins(:worker).
      where("workers.pps" => should_pps)
  end
  
  # Scope returning shares that are part of the round relevant to
  # the block passed as argument
  def self.relevant_to(block)
    pps(false).
      where("`shares`.`id` <= ?", block.share.id).
      where("`shares`.`id` >= ?", block.first_share_of_round_id)
  end

  # Deletes shares relevant to a particular block after they've
  # been properly accounted for
   def self.delete_relevant_to!(block)
     where("`shares`.`id` <= ?", block.share.id).
      where("`shares`.`id` >= ?", block.first_share_of_round_id).
      where("EXISTS (SELECT * FROM `workers` WHERE `shares`.`username` = `workers`.`username` AND (`workers`.`pps` IS NULL OR `workers`.`pps` = 0))").
      delete_all
   end
end