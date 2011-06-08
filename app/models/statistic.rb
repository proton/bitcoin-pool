class Statistic < ActiveRecord::Base
  default_scope order("recorded_at ASC")

  belongs_to :worker

  belongs_to :user

  validates :metric,
    :presence => true

  validates :value,
    :presence => true

  # Records the server hashrate
  def self.record_global_hashrate!
    create!({
        :metric => 'hashrate',
        :value => Share.hashrate,
        :recorded_at => DateTime.now
      })
  end

  # Records individual worker hashrates
  def self.record_worker_hashrates!
    recorded_at = DateTime.now

    Worker.all.each do |worker|
      create!({
          :metric => 'hashrate',
          :value => worker.hashrate,
          :worker => worker,
          :user => worker.user,
          :recorded_at => recorded_at
        })
    end
  end

  # Scopes on hashrate metric
  def self.hashrate
    where("metric = ?", "hashrate")
  end

  # Scopes stats by worker
  def self.with_worker(worker)
    where("worker_id = ?", worker.id)
  end

  # Removes old individual stats
  def self.purge!
    where("created_at < ?", DateTime.now.advance(:days => -7)).
      where("user_id IS NOT NULL").
      delete_all
  end
end
