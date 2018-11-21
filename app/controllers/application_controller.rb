class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  helper_method :current_user, :remote_ip
 
  def require_user
    redirect_to new_session_path unless current_user
  end

  def require_guest
    redirect_to tasks_path if current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      '8.8.8.8'
    else
      request.remote_ip
    end
  end
end
