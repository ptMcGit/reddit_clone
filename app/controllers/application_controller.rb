class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |e|
    flash[:danger] = "NO!"
    begin
      redirect_to :back
    rescue
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password)
    end
    devise_parameter_sanitizer.permit(:edit) do |account_params|
      account_params.permit(:email, :password, :current_password)
    end
  end
end
