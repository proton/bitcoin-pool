class WorkersController < ApplicationController 
  def index
    @workers = current_user.workers
  end
  
  def new
    @worker = current_user.workers.build
  end
  
  def edit
    get_worker
  end
  
  def create
    @worker = current_user.workers.build
    perform_update!
  end
  
  def update
    get_worker

    # It shouldn't be possible to change the worker type after creation
    params[:worker].delete(:pps)
    
    perform_update!
  end
  
  def destroy
    get_worker.destroy
    
    redirect_to user_root_path,
        :notice => t("flash.worker_destroyed")
  end

  def show
    get_worker
  end

  def cash_out
    get_worker.cash_out!

    redirect_to user_root_path,
      :notice => t("flash.cashed_out")
  end

  private
  
    def perform_update!
      if @worker.update_attributes(params[:worker])
        redirect_to user_root_path,
          :notice => t("flash.worker_saved")
      else
        render :action => :new
      end
    end

    def get_worker
      @worker = current_user.workers.find(params[:id])
    end
end

