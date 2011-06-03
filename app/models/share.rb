class Share < ActiveRecord::Base  
  # We want to deal with accepted shares unless otherwise specified
  default_scope where("our_result = 'Y'")

  # A share always belongs to a worker, we need to supply custom join
  # keys to match the DB structure pushpool is expecting
  belongs_to :worker,
    :foreign_key => "username",
    :primary_key => "username"
  
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
end
