class BlocksController < ApplicationController
  def index
    @blocks = Block.all
  end
end
