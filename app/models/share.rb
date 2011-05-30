class Share < ActiveRecord::Base
  # We want to deal with accepted shares unless otherwise specified
  default_scope where("our_result = 'Y'")


  # Filters on fresh shares
  def self.fresh(limit = DateTime.now.advance(:minutes => -10))
    where("created_at > ?", limit)
  end

  # Returns hashrate averaged on last 10 minutes, at diff. 1 each share
  # represents 2^32 hashes.
  def self.hashrate
    # => (fresh.count.to_f * 2**32 / (10 * 60)) / (10 ** 9)
    0.007158278826666666 * fresh.count
  end
end
