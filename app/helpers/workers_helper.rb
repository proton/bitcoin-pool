module WorkersHelper
  def last_share_for(worker)
    distance_from_time_in_words(worker.last_share_at)
  end
  
  def stale_shares_for(worker)
    if worker.current_shares.zero?
      "N/A"
    else
      "#{worker.stale_shares} (#{"%.2f" % ((worker.stale_shares.to_f / worker.current_shares.to_f ) * 100)}%)"
    end
  end
end
