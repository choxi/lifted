class LogsController < ApplicationController
  def index
  end

  def new
    if user = User.find_by(authentication_token: params[:authentication_token])
      sign_in user
      render "index"
    else
      redirect_to root_path
    end
  end
end