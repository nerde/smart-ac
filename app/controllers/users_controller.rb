class UsersController < ApplicationController
  before_action :set_user, only: %i[lock unlock]
  before_action :authenticate_user!

  def index
    @users = User.order(:email).page(params[:page])
  end

  def lock
    @user.lock_access!
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was locked' }
      format.json { head :no_content }
    end
  end

  def unlock
    @user.unlock_access!
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was unlocked' }
      format.json { head :no_content }
    end
  end

  def invite
    email = params[:email]

    User.invite!(email: email)

    redirect_to users_path, notice: "Invitation sent to #{email}"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
