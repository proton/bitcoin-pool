class UsersController < ApplicationController
  before_filter :set_user
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path,
        :notice => "io"
    else
      render :action => :edit
    end
  end

  def show
  end

  private
  
  def set_user
    @user = current_user
  end  
end
