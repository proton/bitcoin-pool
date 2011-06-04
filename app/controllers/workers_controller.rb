class WorkersController < ApplicationController 
  def index
    @workers = current_user.workers
  end
  
  def new
    @worker = current_user.workers.build
  end
  
  def edit
    @worker = current_user.workers.find(params[:id])
  end
  
  def create
    @worker = current_user.workers.build
    perform_update!
  end
  
  def update
    @worker = current_user.workers.find(params[:id])

    # It shouldn't be possible to change the worker type after creation
    params[:worker].delete(:pps)
    
    perform_update!
  end
  
  def destroy
    @worker = current_user.workers.find(params[:id])
    @worker.destroy
    
    redirect_to user_root_path,
        :notice => t("flash.worker_destroyed")
  end

  def show
    @worker = current_user.workers.find(params[:id])
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
end

