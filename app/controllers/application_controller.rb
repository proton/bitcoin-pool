class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!,
    :ensure_utc_timestamps,
    :get_stats
    

  private

  # Sets variables with the global pool hashrate averaged on the last 10 minutes
  # and the number of active workers
  def get_stats
    @hashrate = "%.2f" % Share.hashrate.to_s
    @workers = Worker.recently_active
  end

  # Ensures that all timestamps comparisons compare UTC timestamps
  def ensure_utc_timestamps
    ActiveRecord::Base.connection.execute("SET TIME_ZONE = '+00:00'")
  end
end
