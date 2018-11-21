class SessionsController < ApplicationController
  before_action :require_guest, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: user_params[:name])
    @user ||= User.create(user_params)
    if @user.valid? && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      SessionMailer.with(user: @user).sigh_in_email.deliver_later
      set_last_seen
      redirect_to tasks_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  def user_location
    location = Geocoder.search(@user.last_ip)
    location = location.first.city << ", " << location.first.region << ", " << location.first.country
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :email)
  end

  def set_last_seen
    @user.update_attribute(:last_seen_at, Time.current)
    @user.update_attribute(:last_ip, remote_ip)
    @user.update_attribute(:last_location, user_location)
  end
end
