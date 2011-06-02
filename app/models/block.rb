class Block < ActiveRecord::Base
  default_scope order("found_at DESC")

  belongs_to :worker

  #  validates :number,
  #    :presence => true,
  #    :uniqueness => true

  validates :found_at,
    :presence => true

  #    validates :user_id,
  #      :presence => true

  validates :checksum,
    :presence => true,
    :uniqueness => true

  def confirmed?
    confirmations >= 120
  end

  def self.fetch_new
    Share.where(:upstream_result => "Y").all.each do |share|
      b = BlockHeader.new(share.solution)

      if Block.where(:checksum => b.hash).count.zero?
        b = Block.create!({
            :found_at => Time.at(b.timestamp),
            :checksum => b.hash,
            :worker => share.worker
          }
        )
      end
    end
  end

  def self.update_confirmations
    Block.where("confirmations < ?", 120).each do |block|
      btc = Bitcoin::Client.new
      blk = btc.get_block_by_hash(block.checksum)
      
      # This assumes the generation tx is always the first in the tx array
      tx  = btc.get_transaction(blk["tx"][0]["hash"])

      block.update_attributes!({
          :confirmations => tx["confirmations"],
          :generated => tx["amount"]
        }
      )
    end
  end
end
