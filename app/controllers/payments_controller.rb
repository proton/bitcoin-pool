class PaymentsController < ApplicationController
  def index
    @payments = current_user.payments
  end

  def show
    @payment = current_user.payments.find(params[:id])
  end
end
