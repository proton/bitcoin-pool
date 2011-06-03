class UsersController < ApplicationController
  before_filter :set_user
  
  def edit
  end
  
  def update
    # This flag is *not* supposed to be toggled here
    params[:user].delete(:admin)

    if @user.update_with_password(params[:user])

      # Necessary because a password change signs you out
      sign_in(@user, :bypass => true)

      redirect_to edit_user_path,
        :notice => t("flash.account_edited")
    else
      render :action => :edit
    end
  end

  def show
    @blocks = Block.all
  end

  private
  
  def set_user
    @user = current_user
  end  
end
