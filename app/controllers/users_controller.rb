class UsersController < ApplicationController
  before_action :authenticate_user! , except: :check_email

  def check_email
    @user = User.find_by_email(params[:user][:email])
    respond_to do |format|
      format.json { render :json => !!@user }
    end
  end

  def index
    redirect_to items_path
  end
end
