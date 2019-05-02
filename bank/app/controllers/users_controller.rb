class UsersController < ApplicationController
  before_action :authenticate_user!

  respond_to :html, :json

  def index
    @users = User.where.not(id: current_user.id).select(:id, :full_name)
    render
  end
end
