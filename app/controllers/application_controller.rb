class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!,
    :ensure_utc_timestamps,
    :get_stats,
    :get_hashrate_stats

  
  private

    # Sets variables with the global pool hashrate averaged on the last 10 minutes
    # and the number of active workers
    def get_stats
      @hashrate = "%.2f" % Share.hashrate
      @active_workers = Worker.recently_active
    end

    # Ensures that all timestamps comparisons compare UTC timestamps
    def ensure_utc_timestamps
      ActiveRecord::Base.connection.execute("SET TIME_ZONE = '+00:00'")
    end

    def get_hashrate_stats
      @series = Statistic.global.all.map do |s|
        [s.recorded_at.strftime("%Y-%m-%d %H:%M:%S"), (s.value/1000000)]
      end
#      line = Statistic.
#        T
#      rade.with_currency(currency).map do |trade|
#        [trade.created_at.strftime("%Y-%m-%d %H:%M:%S"), trade.ppc.to_f]
#      end
    end
end
