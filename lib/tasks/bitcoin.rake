namespace :bitcoin do
  desc "Updates the block table"
  task :update_blocks => :environment do
    Block.update_all
  end
end