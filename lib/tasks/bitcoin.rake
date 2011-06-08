namespace :bitcoin do
  desc "Updates the block table"
  task :update_blocks => :environment do
    Block.fetch_new
    Block.update_confirmations
    Block.create_contributions
  end

  desc "Pushes payments to users once their balance is over their threshold"
  task :pay_users => :environment do
    User.pay!
  end

  desc "Periodically records various metrics"
  task :record_stats => :environment do
    Statistic.record_global_hashrate!
    Statistic.record_worker_hashrates!
  end
end