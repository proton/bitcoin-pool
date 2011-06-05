class UsersController < ApplicationController
  before_filter :set_user,
    :remove_sensitive_fields
  
  def update
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

    # Removes forged parameters from update requests, maybe we should also
    # implement a big fat banhammer.
    def remove_sensitive_fields
      if params[:user] && [:admin, :pps_balance].any? { |p| params[:user].delete(p) }
        redirect_to user_root_path,
          :alert => t("flash.dont_even")
      end
    end
end
