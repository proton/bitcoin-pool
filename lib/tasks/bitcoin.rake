namespace :bitcoin do
  desc "Updates the block table"
  task :update_blocks => :environment do
    Block.fetch_new
    Block.update_confirmations
  end

  desc "Pushes payments to users once their balance is over their threshold"
  task :pay_users => :environment do
    User.pay!
  end
end