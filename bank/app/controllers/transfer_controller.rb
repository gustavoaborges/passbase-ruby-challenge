class TransferController < ApplicationController
  before_action :authenticate_user!

  # I honestly would rather use Grape, Grape-Entity and Grape Swagger and JWT auth...
  # but this effort has time limitations
  def index
    redirect_to(root_url, alert: 'Missing parameters') and return unless accepted_params.present?
    svc = TransactionCreator.new
    from_user = current_user
    pp accepted_params
    to_user = User.find(accepted_params[:target_user_id])

    # render({message: 'Targe user could not be found', error: true}.to_json, status: 404) unless to_user.present?
    redirect_to(root_url, alert: 'Targe user could not be found') and return unless to_user.present?
    begin
      amount = Money.new(Float(accepted_params[:amount_dollars]) * 100, accepted_params[:amount_curr])
      transaction = svc.perform!(from_user, to_user, amount)
    rescue Money::Currency::UnknownCurrency
      redirect_to(root_url, alert: 'Invalid currency') and return
      # render {message: 'Invalid currency', error: true}.to_json, status: 400
    rescue => err
      redirect_to(root_url, alert: "An unexpected erro occured while processing your request. #{err.message}") and return
      # render {message: 'An erro occured while processing your request', error: true}.to_json, status: 500
    end
    # render {message: 'Transaction created', error: false}.to_json, status: 201
    redirect_to(root_url, notice: 'Transaction created')
  end

  def accepted_params
    params.permit(
      :target_user_id,
      :amount_dollars,
      :amount_curr,
      :authenticity_token
    )
  end
end
