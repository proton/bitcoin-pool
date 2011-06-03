class Contribution < ActiveRecord::Base
  belongs_to :block
  belongs_to :worker
end
