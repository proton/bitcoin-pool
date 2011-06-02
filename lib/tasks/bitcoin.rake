namespace :bitcoin do
  desc "Updates the block table"
  task :update_blocks => :environment do
    Block.fetch_new
    Block.update_confirmations
  end
end